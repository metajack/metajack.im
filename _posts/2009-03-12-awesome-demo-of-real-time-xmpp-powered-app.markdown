---
layout: post
title: "Strophe in Action: Drop.io's Awesome XMPP Powered App"
tags: [xmpp, jabber, strophe, javascript, dropio]
time: "16:19"
extended: ":EXTENDED:"
---

[Drop.io](http://drop.io) just
[announced](http://drop.io/blog/asset/your-drops-are-now-alive-private-filesharing-and-collaboration-goes-truly-real-time)
that their collaboration service is now a real time Web application.
I got word from them that this amazing new stuff is powered by
[XMPP](http://xmpp.org) via 
[Strophe](http://code.stanziq.com/strophe).  They have certainly added
a lot of elbow grease, passion, and magic on top to make this
possible, but this is a terrific example of what I envision with XMPP
powered Web applications.

To get the full effect, I highly recommend watching their [real time
demo screencast](http://drop.io/file/streaming).

They have this to say about the technical details:

> Using the Jabber (XMPP) protocol and through a chain of events mediated by JavaScript, BOSH and XMPP drops are now updated for all users viewing that drop in real-time. We are using ejabberd, which is known for its high level of compliance with XMPP. On the front end we use the Strophe javascript library, which uses  a technique called Bidirectional-streams Over Synchronous HTTP (BOSH) to connect to a Jabber server.

> Each drop is assigned its very own chat room on our Jabber setup, and whenever a user views the drop, Strophe automatically logs the user into the drop’s chat room. Whenever an event such as a file creation occurs, drop.io's application servers send an XMPP message to the drop’s chat room describing the event.

This is not far off from the structure of
[Chesspark](http://www.chesspark.com), and shows just how powerful a
few XMPP technologies can be when combined well.  One neat side effect
of this is that they will have a public API for free that has robust
support in many languages already.  Maybe some day they will enable
Drop.io features in arbitrary chat rooms as well!

Congratulations to the whole Drop.io team on a successful launch of a
very cool product!
