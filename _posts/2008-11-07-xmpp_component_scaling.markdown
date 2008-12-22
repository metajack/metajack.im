---
layout: post
title: XMPP Component Scaling
tags: [ejabberd, jabber, scaling, xmpp]
time: "22:03"
extended: ":EXTENDED:"
---

Someone [asked](http://mail.jabber.org/pipermail/ws-xmpp/2008-October/000070.html) about how to handle heavy loads on [ejabberd](http://www.ejabberd.im) servers, and an [interesting discussion](http://mail.jabber.org/pipermail/ws-xmpp/2008-November/000076.html) ensued.  Most of the discussion is applicable to any XMPP server, but as I pointed out in the thread, ejabberd has some nice features for component scaling.  The main router in ejabberd will round-robin load balance components that connect with the same JID.

The load balancing is simple, but it could be useful in a number of situations.  It would be even better if ejabberd implemented this in a module and had hooks so that people could implement their own load balancers.  I can imagine writing a nice custom balancer that queried the components and spread load to the most lightly loaded ones first.

Jabberd2 didn't have anything this fancy, but I wonder if any of the other big XMPP servers have such a thing.

:EXTENDED:


