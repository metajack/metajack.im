---
layout: post
title: "Strophe Preview: XMPP In JavaScript"
tags: [bosh, chesspark, code, jabber, strophe, xmpp]
time: "11:24"
extended: ":EXTENDED:"
---

Three years ago, we released <a href="http://www.onlinegamegroup.com/projects/libstrophe">libstrophe</a> to the world.  libstrophe is a cross-platform C library for writing XMPP clients.  libstrophe exists because none of the C libraries at the time worked well on Windows platforms.  A year or so later, I discovered the potential of XMPP on the Web and created a JavaScript version as a first step to a Web based <a href="http://www.chesspark.com/">Chesspark</a> client.  I never officially released strophe.js, but it is available under the GPL license for anyone who was brave enough to dig it out of the Chesspark JavaScript code.  It's time to make it official.

<strong>Some Features Of Strophe</strong>

Strophe has a lot of neat features.  Probably the most compelling is that it has been well tested for 2 years in all major browsers.  It catches many errors and includes optimizations that no other AJAX framework seems to.  It has been used by hundreds of thousands of people via the Chesspark site.

Strophe was developed in a climate where low latency is critical.  People do not enjoy waiting for game moves or clock updates, and so Strophe does its best to deliver excellent performance.

Strophe is very simple.  Not only is the API small and easy to understand, but there are numerous helpers in there to make life easy.  Strophe.Builder helps you build stanzas quickly.  For example:
<pre>$iq({type: 'get'})
    .c('query', {xmlns: Strophe.NS.ROSTER})
    .toString()</pre>
Will generate this XML stanza:

<code>
&lt;iq type='get'&gt;
&lt;query xmlns='jabber:iq:roster'/&gt;
&lt;/iq&gt;
</code>

<strong>Strophe In Action</strong>

If you'd like to see what is possible with Strophe, please check out the <a href="http://www.chesspark.com/play/">Chesspark Web client</a> and the <a href="http://www.speeqe.com/">Speeqe demo site</a>.

<strong>Take a Sneak Peek</strong>

I'm almost finished preparing Strophe 1.0 for release, which includes the original libstrophe C library, the strophe.js JavaScript library, and <em>complete</em> documentation for both.  I hope to make Strophe the best XMPP library around for native or web development.

Until it is released, you can can see a <a href="http://people.chesspark.com/~jack/strophe-preview/strophe.js">preview of the JavaScript version</a> or read the <a href="http://people.chesspark.com/~jack/strophe-preview/doc/files/strophe-js.html">API documentation</a>.  This version was refactored and made more modular compared to the <a href="http://www.chesspark.com/play/scripts/strophe.js">Chesspark version</a>, and it hasn't been fully tested yet.  It does however work great in my initial tests with a slightly modified version of the Chesspark Web client.

I'm very interested in any feedback the community has for Strophe.

:EXTENDED:


