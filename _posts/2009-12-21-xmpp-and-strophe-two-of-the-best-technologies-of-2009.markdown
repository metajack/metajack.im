---
layout: post
title: "XMPP and Strophe: Two of the Best Technologies of 2009"
tags: [jabber, xmpp, strophe, javascript]
time: "23:30"
extended: ":EXTENDED:"
---

A [great thread](http://news.ycombinator.com/item?id=1005884) was
started on [Hacker News](http://news.ycombinator.com) yesterday asking
what the best technologies were that people worked with in 2009. I was
thrilled to see [XMPP](http://xmpp.org) and
[Strophe](http://code.stanziq.com/strophe) listed not once, but twice!

Here's what one user [had to
say](http://news.ycombinator.com/item?id=1006060) about it:

> Earlier this year I got tasked with implementing a system which
  involved multiple mobile clients talking to a rendering server. The
  mobile devices had a fairly beefy browser (Nokia N900), so the
  client was clearly suitable to be delivered as a web app. On the
  server side, we already had a realtime graphics system I had written
  earlier, to which the web clients would need to talk over a
  bidirectional connection with near-realtime responsiveness.  
>
> ...
>
> [My work partner] showed me some demos of realtime XMPP web apps
  built with Strophe.js, and I was rather impressed. Then we went over
  our system's client/server design and how it would map to XMPP, and
  I was sold.
>
> We ended up using many more XMPP features than I had
  initially imagined, including publish/subscribe and multi-user chat
  rooms. Had we gone with my original approach, these concepts would
  have been implemented in some haphazard way in the render server
  itself. Now the rendering system just talks to the XMPP server like
  any other client. It's stable, scalable and fast.

The built-in tools in XMPP are quite powerful and can be applied to a
huge range of problems. The layered extensions like
[pubsub](http://xmpp.org/tech/pubsub.shtml) and [multi-user
chat](http://xmpp.org/tech/muc.shtml) provide robust and well tested
building blocks on which to create great things. There is now a decade
of shared knowledge and experience baked into XMPP and its many
extensions, and it's great to see more and more people discovering
this.

I'm really excited to see what will come in 2010!
