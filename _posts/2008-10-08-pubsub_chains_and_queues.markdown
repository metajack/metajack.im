---
layout: post
title: PubSub Chains And Queues
tags: [jabber, pubsub, xmpp]
time: "21:26"
extended: ":EXTENDED:"
---

There are two new [XMPP PubSub](http://www.xmpp.org/extensions/xep-0060.html) extensions being proposed at the [XSF](http://www.xmpp.org).  The first one is for [pubsub chaining](http://xmpp.org/extensions/inbox/pubsub-chaining.html), and this defines how a pubsub node subscribes and re-publishes items from one or more local or remote pubsub nodes.  The second is for [pubsub queueing](http://xmpp.org/extensions/inbox/pubsub-queueing.html), which enables queue like behavior for a pubsub node.  These ideas are young and fresh, and the XSF would love your feedback on them.

## Chaining

Pubsub chaining can be used for a number of problems.  The most interesting to me is its potential for use in aggregation of pubsub content.  In the scenario where microblogs are just [PEP](http://xmpp.org/extensions/xep-0163.html) or pubsub nodes, it is very useful to aggregate all of the microblog nodes under a single feed for use by third party service providers.  It could also be used to establish and manage pubsub based [planets](http://www.planetplanet.org/).

## Queueing

Pubsub queueing is an attempt to map a queue like API onto pubsub nodes.  While some people are building [pubsub on top of queues](http://anders.conbere.org/journal/rabbiter-open-federated-pubsub-server/), this proposed extensions builds queues on top of pubsub.  This could be extremely useful for decoupling applications or spreading workload to an army of worker processes.

## We Need Help

There is still much work to be done, and several of us have been proposing changes and additions on the [pubsub mailing list](http://mail.jabber.org/mailman/listinfo/pubsub).  Please come and participate and share your use cases, feature ideas, and feedback.

:EXTENDED:


