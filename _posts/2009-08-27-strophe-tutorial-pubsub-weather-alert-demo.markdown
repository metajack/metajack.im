---
layout: post
title: "Strophe Tutorial: Pubsub Weather Alert Demo"
tags: [xmpp, jabber, strophe, pubsub, ejabberd, erlang, javascript]
time: "10:08"
extended: ":EXTENDED:"
---

[Strophe](http://code.stanziq.com/strophe) has been getting more
popular lately, and I keep finding it in new places.  [Boris
Okner](http://rfid-ale.blogspot.com/) has just written an [interesting
demo
application](http://rfid-ale.blogspot.com/2009/08/real-time-web-applications-with-xmpp.html)
showing off the power of the real-time Web and Strophe.  He didn't
just stop with the demo, either; he has provided a [detailed
walk-through](http://rfid-ale.blogspot.com/2009/08/xmpp-web-project-walkthrough.html)
of how it all works as well.

<img src='/images/weazard.png' width='400' alt='Weather Demo Screenshoot'/>

The demo is an imaginary system for weather alerting that allows users
to subscribe to various weather stations and receive updates in
real-time.  It uses Strophe and JavaScript for the front end and
[ejabberd](http://www.ejabberd.im) and some custom
[Erlang](http://www.erlang.org) modules for the back end.  The XMPP
API exposed by the server is similar to standard
[XMPP pubsub](http://xmpp.org/tech/pubsub.shtml), which can be browsed via
[service discovery](http://xmpp.org/extensions/xep-0030.html).

I also really like Boris's description of XMPP's advantages to tackling this problem:

> Another important thing is ability to reuse XMPP server
> features. For instance, there is no need to have separate database
> of registered users and their subscriptions, as this is already
> maintained by XMPP server. All changes in user's presence
> (i.e. logged in/out, disconnected) and component presence (restart,
> disconnection etc.) are also taken care of. It is possible to easily
> implement IM features, such as live support or chat between users.

I'd add that if he had used standard pubsub, there is very little
protocol design work that needs to be done for this type of
application.  Pubsub and service discovery already have all the
standard usage models covered as well as many error cases.  It's a lot
easier to implement a well thought out protocol than to design your
own and re-discover all the non-obvious issues.

Give Boris's demo application a spin if you're interested in what is
possible with the real-time Web and how it works.


