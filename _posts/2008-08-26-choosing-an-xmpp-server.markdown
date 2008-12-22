---
layout: post
title: Choosing An XMPP Server
tags: [c, chesspark, code, ejabberd, erlang, jabber, jabberd, jabberd2, java, openfire, server, tigase, xmpp]
time: "09:49"
extended: ":EXTENDED:"
---

Choosing an XMPP server is a big decision.  Should you go with the popular one or the one written in the most popular language?  Perhaps you don't plan to become a systems administrator and you need one which is easy to set up and maintain.  Unfortunately for people making this important choice, there is not much guidance published beyond features comparisons.  What follows is an account of our decision making process on XMPP servers - how we came to pick jabberd2 originally, and how we switched to ejabberd.

<strong>A Brief History Of XMPP Servers</strong>

XMPP began as Jabber and had only one server, jabberd.  As popularity of the protocol grew, more servers appeared, and now there are half a dozen major contenders, both commercial and open source.

The main players these days seem to be:
<ul>
	<li><a href="http://jabberd.org/"><strong>jabberd</strong></a> - The original server.  It started in C, but now appears to be a mix of C and C++ code.  The main users for years was jabber.org itself.  The code may have changed substantially in the last couple of years, but I remember it being rather crufty.  Matthias Wimmer has been maintainer at least since 2004, and he continues to maintain it today, although it does go through some long periods of inactivity.</li>
	<li><a href="http://jabberd2.xiaoka.com/"><strong>jabberd 2.x</strong></a> - A rewrite of jabberd, originally by Rob Norris.  The code is pure C, modular, and fairly easy to understand.  Chesspark picked this to start with in 2006.  Another notable user of jabberd 2.x is Meebo.  Unfortunately it was abandoned by its original maintainers some time ago.  Tomas Sterna stepped up to the plate and took over the project, and it is now actively maintained again.</li>
	<li><a href="http://www.ejabberd.im"><strong>ejabberd</strong></a> - An XMPP server written in <a href="http://erlang.org/">Erlang</a> which claims to be quite scalable.  Erlang is the language created decades ago by Ericcson to power their telephone switches.  It has many features that make it well suited for XMPP servers.  ejabberd has been around and active since early 2005, and is supported officially by Process One.  It also has a growing developer community.  Jabber.org switched from jabberd to ejabberd some time ago, and continues to run ejabberd today.</li>
	<li><a href="http://www.igniterealtime.org/projects/openfire/index.jsp"><strong>Openfire</strong></a> - A Java server written by JIVE Software.  This was formerly a commercial product called Wildfire.  I have no personal experience with it, but it appears to have an active community.</li>
	<li><a href="http://www.tigase.org"><strong>Tigase</strong></a> -Another Java server that started in late 2004.  It is actively maintained.  I have no personal experience with Tigase other than meeting Artur at the recent XMPP Summit, but the Seesmic folks speak very highly of the project.</li>
</ul>
This list is incomplete.  Notable omissions include Google Talk (not publically available), Jabber XCP (the commercial offering from Jabber.com), and djabberd (Danga's jabber server written in Perl).

<strong>Chesspark's Initial Decision</strong>

Chesspark chose jabberd2 as its XMPP server about 3 years ago.  I recall being impressed with the clean and modular code base as well as its ability to change the SQL queries right in the configuration file.  It also supported PostgreSQL which was the RDBMS we preferred.  I don't think that Tigase or ejabberd were considered; they were likely too young at the time.  Jabberd was the only other real choice, but we were not impressed with the code.

One major factor which influenced our decision was code readability and maintainability.  We wanted an XMPP server that we could patch ourselves if needed, and we didn't want to be stuck in case the project was abandoned down the road.  This turned out to be a wise decision - the jabberd 2.x project was unmaintained for a long period while we used it.  Over the last few years we've made patches and assisted others with patches as best we can.

<strong>Jabberd 2.x Disappointment</strong>

Over time, Chesspark's user base got larger as the site became more popular, and jabberd 2.x's warts began to show.  Here are the main ones in the approximate order we discovered them.
<ul>
	<li><strong>Database transactions abused</strong>.  Jabberd 2.x does no queries out of the box that require the use of database transactions.  By default it is configured to do every query in a transaction, even if it is a simple SELECT.  This is a common problem with many libraries we've used at Chesspark.  Thankfully, jabberd 2.x can be configured to turn this off.  Normally this would not affect anything, but the small amount of overhead caused can add up fast when jabberd 2.x does lots of queries, which it certainly does.</li>
	<li><strong>Memory leaks.</strong> There are several memory leaks that persist to this day.  Even with a small userbase like Chesspark has, this forces us to restart the server about once a week.  As memory usage climbs, the server latency gets higher.  Our attempts to find this leak have been unsuccessful to date.</li>
	<li><strong>Non-blocking design inconsistent. </strong> The server uses a non-blocking design common to scalable daemons; this is great.  Unfortunately, all database calls use the blocking database API and a single database connection.  This means that even with light load, packet latencies can be quite high if the database isn't ridiculously fast.</li>
</ul>
For us, the show stopper was latency.  Games depend on near real-time performance, and latency destroys the user experience.  We generated test load which logged in a few hundred users, did roster operations, logged out, and repeated.  We then measured latency of chess moves on the same server.  We were shocked when we saw the numbers - over 3 seconds of lag between an IQ query and its response.

All of these things could theoretically be fixed, and I hope that they are fixed eventually.  Diversity in server choices is a feature of XMPP - the more the merrier.

<strong>Finding A New Server
</strong>

Once we decided to abandon jabberd2, we needed to find a new server.

Feature wise, all the current servers support the stack we need - authentication with TLS and SASL, ability to use PostgreSQL as a backend, private XML storage, external components, and privacy lists.  Years ago, some of these features were hard to come by, but today they are common.  ejabberd, Openfire, and Tigase have pubsub and BOSH support as well, neither of which was available in any open source server when we started.

We knew right off the bat that we didn't want to be writing C.  While we have a lot of C experience, we like to reserve C for the few times it is actually needed and spend the rest of our time in more productive and higher level languages.  This removed jabberd from the list.

From here the language choice is Erlang or Java.  Erlang is a dynamically typed, functional language - quite a radical departure from the norm for people most C and Java hackers.  We work a lot in Python, so Erlang was the closer fit.  Many people make the decision to work in Java, and from there they will need to pick between Tigase and Openfire.

One thing to note is that some people seem scared away by the Erlang language.  Don't be one of these people.  Erlang is well documented and pretty easy to learn.  We knew nothing about Erlang a few months ago.  That did not slow us down too much when we needed to write ejabberd modules or make changes in ejabberd internals.  Even without knowing Erlang, we were able to write extensions to ejabberd much faster than for jabberd2.

The last part of our decision was to test server latency with ejabberd.  We ran the same test that we ran on jabberd2, and ejabberd didn't flinch.  The measured latency at idle was twice as fast in some cases with ejabberd, and there was very little change even as we pounded the database to levels that would have made jabberd2 cry.

<strong>Life With Ejabberd
</strong>

ejabberd is not perfect; no server is.  Here's a list of our current gripes:
<ul>
	<li><strong>Memory hog</strong> - Erlang uses a lot of memory for basic string handling since a string is represented as a list of integers.  There also seems to be a bug in TLS that causes it to use quite a bit more memory than non-TLS connections.  These add up to quite a bit of memory usage.  For Chesspark, we use over a gig of RAM for a few hundred connections.  Jabber.org uses about 2.7GB of RAM for its 10k+ connections.  I'm not sure what the discrepancy is between these numbers; we are still looking. I expect the TLS memory issue to be solved soon, and the Process One folks told me that they were going to switch the string handling to use Erlang binaries which are more memory efficient.</li>
	<li><strong>Lots of database queries</strong> - As with jabberd2, ejabberd does an enormous amount of database queries.  With mod_privacy enabled, two roster related queries are done <em>for every packet sent</em>.  ejabberd also uses the database inappropriately, with idioms like SELECT, DELETE, INSERT which can lead to race conditions.  Thankfully, this does not seem to be a big problem with a correctly tuned database, as ejabberd doesn't block on the queries.</li>
	<li> <strong>Lack of comments in the code</strong> - The code is often quite clear, but comments would be helpful.  There is some basic, but very helpful, developer documentation, but the code contains virtually no comments.  Luckily, this is not as bad as it seems,because many of the idioms in the server are really Erlang and OTP idioms, so reading up a bit on Erlang and OTP answers a lot of questions.  I'm also not sure other servers are better.  Jabberd2 probably had more comments, but it also had less documentation in general; I've found working with ejabberd to be easier.</li>
</ul>
There are many excellent things about ejabberd that make up for these and other shortcomings, and have made us very happy we made the switch.
<ul>
	<li><strong>Hot code loading</strong> - After we write a new ejabberd module, we can deploy it in production without pausing or restarting the server.  We can also redeploy it later if we find a bug.  We have even redeployed core server pieces this way with success.  This can even be done to some degree right in the Web interface.</li>
	<li><strong>Live console</strong> - It is possible to open an Erlang shell inside the running ejabberd node.  This makes it really easy to poke around to see which processes are running, how much memory they are using, and which internal database tables are getting full.  Java, C, Python, and Ruby have nothing quite like this, although Twisted Python's manhole is similar.</li>
	<li><strong>Very low CPU usage</strong> - You'd think a C based XMPP server would be a winner in this area, but that is not always true.  ejabberd uses very little CPU usage, except when things go wrong.   Chesspark's XMPP server is sitting around a load of 0.1 to 0.2; Jabber.org sits at 0.1.  This is exactly what you want.  An XMPP server should be I/O bound, not CPU bound.</li>
</ul>
So far we're pretty happy.  How did you pick your XMPP server?

:EXTENDED:


