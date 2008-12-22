---
layout: post
title: Fault Tolerant Components
tags: [jabber, xmpp]
time: "09:59"
extended: ":EXTENDED:"
---

[Tofu](http://thetofu.com/) and I have long talked about a proxying component that provided fault tolerance.  The idea is very similar to [Ralph's](http://ralphm.net) [component proxy and load balancer](http://metajack.im/2008/11/08/more-component-scaling-now-in-python/), and in fact, Ralph's solution could probably be easily modified to provide some fault tolerance.  Our idea was slightly different, though.

We thought it would be interesting to have a stanza queue for the proxied component.  When the component died or needed upgrading, you could take it offline, and the proxy would start queueing all requests.  When the component came back up it could resume processing by handling the stanzas in the queue and then continuing normally.

Our inspiration for this was [Chesspark's](http://www.chesspark.com) arbiter component, which enforces rules in all games.  In order to make bug fixes or add features to the arbiter, it is necessary to take it offline and restart it.  This has the unfortunate side effect of adjourning all games in progress.  It would be far better if we could run arbiter behind such a proxy and silently upgrade or fix the component without the users noticing.

Now that [Wokkel](http://wokkel.ik.nu) provides a easy building block for such functionality, maybe we'll see such a component proxy soon.

:EXTENDED:


