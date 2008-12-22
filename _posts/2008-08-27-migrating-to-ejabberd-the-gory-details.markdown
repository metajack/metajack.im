---
layout: post
title: "Migrating To Ejabberd: The Gory Details"
tags: [chesspark, code, ejabberd, jabber, jabberd, server, upgrade, wuchess, xmpp]
time: "10:51"
extended: ":EXTENDED:"
---

Yesterday I blogged about <a href="http://metajack.im/2008/08/26/choosing-an-xmpp-server/">choosing an XMPP server</a>.  Once you've made this decision, it is time to get it set up and running great.  If this is your first XMPP server, this is often just some software installation and a little bit of configuration.  However, for those who already have an existing set up, or who have special data or run time requirements, this can involve a substantial amount of work.  It took us about a week to move from jabberd2 to ejabberd at <a href="http://www.chesspark.com/">Chesspark</a>, and this is how we did it.  While I talk mostly about ejabberd and jabberd2, many of the issues are similar to those any deployment or redeployment would face.

<strong>What We Knew At The Start</strong>

There were three main things that we need we needed to work on in order to transition to ejabberd.  These were authentication, data migration, and porting a custom server module.

<strong>Authentication</strong>. Many sites already have a user database they they want to reuse for the XMPP service.  This almost never looks like the bare bones schema that the XMPP servers are configured to use by default.  The first task then becomes to configure the XMPP server to authenticate from this custom user data.

Jabberd2 is a lot more configurable for database authentication than ejabberd.  For starters, it allows you to define the SQL query used to authenticate users right in the configuration file.  With ejabberd the choices are to write your own authentication module, modify the database authentication module to provide your own queries, or use external authentication via a script.

External scripts are pretty easy in ejabberd, but we opted for modifying the queries used for authentication in the ejabberd source.  For anyone trying this themselves, the queries are all in src/odbc/odbc_queries.erl.

The Chesspark service is open to the entire federated XMPP network, and we store member information for everyone in the same place.  This means that we must store the bare JID as opposed to just the node portion.  Some users are local to our server, like jack@chesspark.com, and some are not, such as metajack@gmail.com.  Only the local users will be used for XMPP authentication, but almost every XMPP server is written to expect usernames without domains, and ejabberd is no exception.

Here is what ejabberd's default authentication query looks like:
<pre>get_password(LServer, Username) -&gt;
    ejabberd_odbc:sql_query(
        LServer,
        ["select password from user "
         "where username='", Username, "';"]).</pre>
We changed it to:
<pre>get_password(LServer, Username) -&gt;
    ejabberd_odbc:sql_query(
        LServer,
        ["select password from member "
         "where lower(username)='", Username, "@", LServer, "';"]).</pre>
This wasn't very difficult at all.  We don't need in-band registration, so we didn't change all of the user creation and deletion queries, but those would be very similar to this one.

<strong>Data Migration.</strong> Each XMPP server has its own format for storing data, and if you are switching from one server to another, you will probably want to take your data with you.  At Chesspark, we already had 400,000 users worth of rosters, private XML storage, and privacy lists, and we didn't want our users to lose this information.  Our task was to figure out how to migrate all the jabberd2 data to a form ejabberd could use.

Most XMPP server schemas are quite simple and quite similar.  We achieved 95% of the data migration by using SQL's ALTER TABLE command to add, remove, and rename columns.  The only trouble we ran into was figuring out which columns in jabberd2 mapped to which columns in ejabberd and dealing with virtual hosts.

Figuring out the mapping was pretty straightforward.  We made some users in a test database under the default ejabberd configuration and did some common operations.  Then we inspected the database tables and determined what the columns were for.  For example, we saved some private XML as a user, then looked at how ejabberd's private_storage table stored and formatted the resulting data.  In almost every case, it was extremely simple to migrate the data.  The notable exception is privacy lists, which were stored in two tables in ejabberd instead of just one like jabberd2.  This was easily fixed up with a small Python script.

Dealing with virtual hosts was a bit harder.  We run multiple servers at Chesspark to handle our branded chess sites like <a href="http://www.wuchess.com/">WuChess.com</a>.  We wanted to move from multiple jabberd2 servers to a single ejabberd installation with virtual hosting.  Unfortunately, since ejabberd stores user names without domains, this enforces unique user names across all virtual hosts, a requirement we weren't able to meet with our existing user data.  We decided to patch ejabberd to use the domain along with the user name to make this easier.

These changes were very similar to the changes for authentication above and we modified nearly every query in odbc_queries.erl.  Unfortunately, not every function takes the parameter LServer which is the stringprepped domain, and this made the patch more difficult.  We had to add the LServer variable where it was missing, and then modify the ejabberd internals to pass this along in places where it didn't already do so.  This was pretty easy, except for one or two places where ejabberd passed data in a giant list and we had to fix specific entries in the lists.

Unfortunately, not all the SQL queries are in odbc_queries.erl as the code would have you believe.  We also had to patch the queries in other modules of the code where they had not yet been moved to odbc_queries.erl.  Hopefully the ejabberd team will finish moving these to one place in the future.

After all this patching, it required a few days of testing and tuning to make sure everything was running smoothly.  Supporting virtual hosts by adding the domain to usernames is definitely something I feel should be in upstream ejabberd, and I will send my patch upstream to see if they will add this.

<strong>The Custom Module</strong>. Chesspark is built from a set of components that implement and understand chess rules, player matching rules, and various other things.  These components must receive presence notifications to know when users are on and offline.  It can happen that a presence notification is slightly delayed and stanzas are sent to an offline client.  These don't cause any harm, but they do take up disk space. With a lot of users in the database, this disk space can start to be substantial, so we wrote a custom server module in jabberd2 to ignore traffic to offline storage if it came from certain components.

Porting this module turned out to be very simple.  It took me a few hours to write and test the module.  It would have taken a bit longer had this been my first ejabberd module instead of my second.  Most of the work involved figuring out various bits of the gen_mod API in ejabberd.  For those of you interested in writing or understand ejabberd modules, I highly recommend <a href="http://anders.conbere.org/journal/">Anders Conbere's blog</a> where he has provided <a href="http://anders.conbere.org/journal/building-ejabberd-modules-part-1-compiling-erlang/">several tutorials</a>.

<strong>Putting Ejabberd Into Production</strong>

After all this work and testing, it was time to put ejabberd into production.  We gave notice to the users, took the site offline, and began the data migration process.  This process took longer than our trial runs for some reason, totaling a little bit over an hour.

Once the site came back up, we immediately noticed some problems that we had not caught in our testing.  First, database traffic was extremely high and load was about 4 times higher than we expected.  Next, we discovered that one of our client applications had an infinite loop bug triggered by receiving an echo of your own presence stanzas.  Finally, memory use on the ejabberd server was extreme, and over the next day or so it ran out of memory and crashed 3 times.

<strong>Solving The Problems</strong>

The database problems were the easiest to diagnose thanks to our <a href="http://metajack.im/2007/07/25/do-you-know-what-your-database-is-doing/">database profiling tools</a>.  It was easy to spot a query that was missing an index, and this immediately caused load to drop.  Query traffic was still much to high, and we found two causes for this.

The first cause was our buggy client application which was in an infinite loop sending presence.  This caused a presence storm on the server, causing thousands of useless packets to be sent both to the server and to the user's contacts.  This affected database queries because of the second problem.

The other problem is that mod_privacy_odbc in ejabberd is just terrible.  It does two database queries, one for rosters and one for roster groups, for every single packet that is delivered to a local user.  It does this for the silly purpose of letting stanzas through from your roster contacts that would otherwise be blocked by your privacy settings.  Why this exists, I have no idea, but coupled with the presence storms, it caused a massive amount of database traffic.

A combination of solutions was used to solve these problems.  First we pushed out an upgraded client that did not have the presence storm bug.  Next, we disabled mod_privacy_odbc temporarily to ease the database traffic.  After these were implemented, the server was in good shape, but our users who had contacts still running buggy clients were not.

To solve the problem of people who refused to upgrade, we wrote a new ejabberd module called mod_sunshine, which stopped the presence storms.  mod_sunshine keeps track of duplicate presence sent from users and terminates their session if they send more than X duplicate presence stanzas in Y seconds.  Configured mod_sunshine to kill clients that sent more than 10 stanzas in 60 seconds removed nearly all of the presence storm traffic, and we dealt with the confused users who could not connect with apologetic emails and some upgrade hand holding.

After some new indexes, a new client, and mod_sunshine, we were able to stabilize the database usage and turn back on mod_privacy_odbc.

The last problem was memory use, which was much too high.  We are not sure yet of the true reason for ejabberd's hungry memory needs, but we were able to get past the immediate problem of server crashes by upgrading from 2GB to 8GB of RAM on our XMPP server.  Also, moving from the latest stable release, ejabberd 2.0.1, to the trunk of ejabberd development removed a lot of the memory use.  Memory use is still quite high, about 1.4GB for ~250 simultaneous users, and we'll continue to investigate.  There does seem to be one reported issue that TLS connections take up substantially more memory than non-TLS connections.  Thankfully, unlike jabberd2, we have not detected any major memory leaks, although we are still keeping a close eye on this.

<strong>The End Result - Happy Users</strong>

After a week of patching and preparation and a few frantic days of chasing down glitches, ejabberd is running quite well.  Our users are extolling the lower latency of the new server, which was our ultimate aim with the upgrade.  It seems we have achieved some success for now, but as always, we continue to measure and analyze performance and dream of new improvements we can make.

If you have a story about an XMPP server upgrade gone right or wrong, anecdotes about your favorite or least favorite XMPP server, or just comments or question, please share them with us below.

:EXTENDED:


