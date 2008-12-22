---
layout: post
title: "Ejabberd And Pubsub: It Could Be Much Better"
tags: [ejabberd, jabber, pubsub, xmpp]
time: "20:41"
extended: ":EXTENDED:"
---

[XMPP](http://www.xmpp.org) [Pubsub](http://www.xmpp.org/extensions/xep-0060.html) is one of the most interesting pieces of the XMPP [protocol stack](http://www.xmpp.org/extensions/).  Unfortunately, the current implementations leave a lot to be desired.  Part of the reason for this is because people haven't paid much attention to it until recently, and part of it is because it has a wide variety of use cases and some of them are still getting sorted out.  Ejabberd in particular has an implementation that is lacking in various ways.  



:EXTENDED:

## High Memory Use

Memory use with the ejabberd PEP plugin for pubsub is quite high.  Ever since we've turned on pubsub and PEP at [jabber.org](http://www.jabber.org) we've seen a marked increase in memory use - more than two times the normal amount.  This extra memory use has been responsible for the recent jabber.org downtime.  We've now disabled pubsub and PEP until a workaround or a solution can be found.

It appears that the issue is isolated to the PEP plugin for pubsub, specifically with the [entity capability](http://xmpp.org/extensions/xep-0115.html) cache, and the ejabberd team is investigating it further.  

## Missing Features

ejabberd's implementation is lacking several features.  Here's a few basic ones that I needed but aren't yet implemented (even in the yet-to-be-release 2.1.0).

* **Access models other than presence and open** -  At a minimum I would think people would require the whitelist access model.  It doesn't take too much work before you start wanting a few private pubsub nodes.
* **Multi-subscription support** - [Multi-subscription](http://xmpp.org/extensions/xep-0060.html#subscriber-subscribe-multi) support is quite interesting, and would be very useful for implementing something like Twitter track in an XMPP world.  
* **Missing hooks** - ejabberd modules depends on server hooks to tap into functionality and defined points.  There is only one pubsub related hook currently.  I assume this will evolve as more pubsub functionality is requested and used.

Currently several ideas we are exploring are blocked on these issues.  We're working on patches to address the issues, but I'm sure other people have their pet missing features too.  I looked briefly at [Idavoll](http://idavoll.ik.nu) as an alternative, but it is missing multi-subscribe as well; I didn't check the access model support yet.

It would be really handy to see a feature matrix for all pubsub implementations using the service discovery features listed in [the spec](http://www.xmpp.org/extensions/xep-0060.html).

## First MUC, Then BOSH, Now Pubsub

[Multi-user chat](http://www.xmpp.org/extensions/xep-0045.html) was the first major XMPP extension that came to maturity.  Three years ago, [BOSH](http://www.xmpp.org/extensions/xep-0124.html) support was quite lacking, but now there are a large number of implementations for both clients and servers.  I think the next big push will be for pubsub clients and implementations to mature.

I can't wait, because pubsub is awesome.

*Updated 2008-10-27: Included more details on pubsub memory usage based on ejabberd teams response that it is a PEP issue as does not appear to affect the baseline pubsub.*
