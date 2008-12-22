---
layout: post
title: XMPP Microblogging Thoughts
tags: [http, jabber, microblogging, xmpp]
time: "09:38"
extended: ":EXTENDED:"
---

Those of us in the XMPP community have touted the benefits of our protocol for microblogging for some time.  Even before [Identi.ca](http://identi.ca) and [Laconica](http://laconi.ca/), [Peter Saint-Andre](http://stpeter.im) and Joe Hildebrand drafted a basic [microblogging XEP](http://www.xmpp.org/extensions/inbox/microblogging.html).  Microblogging looks a lot like an impromptu [Multi-User Chat](http://www.xmpp.org/extensions/xep-0045.html) and it is clearly a [Publish-Subscribe](http://www.xmpp.org/extensions/xep-0060.html) based service.  With XMPP you get federation for free; there is no need for a [specification](http://openmicroblogging.org/) on how microblogging sites communicate with each other.  So why hasn't XMPP made inroads in this space?

I'm unsure why so many microblogging attempts have ignored XMPP thus far.  Perhaps in everyone's rush to copy or fix [Twitter](http://twitter.com), no one bothered to research alternative architectures.  I imagine many developers are reluctant to step outside their comfort zone of pre-made libraries for their favorite Web development stack.  After many incompatible implementations of microblogging, the only place we see XMPP is in naive bots that can publish and deliver updates in real time using a standard XMPP client.


:EXTENDED:

## Basic Benefits Of XMPP 

[Stefan](http://blog.jwchat.org/2008/09/09/xmpp-and-microblogging-lets-do-it/) enumerated some of the benefits that microblogging built on XMPP would have: real time communication, elimination of polling, scalability, and federation.

I've written about the importance of real time for microblogging [before](http://metajack.im/2008/09/03/twitters-failures-are-not-xmpps-failures/).  I don't think anyone anticipated that the XMPP interface to Twitter would be so popular as to run into scaling problems.  The fact that many Twitter users are using custom clients that try to hide the latency is proof that real time matters to them.  Providing low latency HTTP APIs requires ridiculous amounts of polling or HTTP callbacks.  The polling can be minimized by [clever representations](http://roy.gbiv.com/untangled/2008/paper-tigers-and-hidden-dragons). Callbacks don't work well on a NATed Internet.  XMPP and its PubSub extension solves these problems.  It provides near real time performance with very little overhead as this was its original design intention.   The 'presence' mentioned in every XMPP document is just a short word for Twitter's catch phrase "What are you doing?".

XMPP scales well, for a number of reasons.  First of all, it is federated.  It is not possible to host the entire world's microblogging on a single service.  XMPP let's services interoperate which allows microblogging to be distributed in a natural way.  There is no doubt that the Web and E-mail are quite scalable technologies, and their brilliant design has inspired XMPP.  Second, PubSub eliminates the need for constant polling, and this drastically reduces the load on the server.  Things like Twitter clients hammering on the HTTP API and FriendFeed trying to keep track of its users are generating millions of unnecessary polling requests.  While these can be optimized (see [SUP](http://blog.friendfeed.com/2008/08/simple-update-protocol-fetch-updates.html) and the previously mentioned article on [better representations](http://roy.gbiv.com/untangled/2008/paper-tigers-and-hidden-dragons)), the closer to real time you get, the less tenable polling becomes.  Push is very efficient at extremely low latencies, and has room still for optimization.

## XMPP Is Even Better

There are a lot of clever clients for Twitter and interesting mashups of the service.  An XMPP based microblogging site could benefit in similar ways.

Right now we are only scratching the surface of what is possible in this space. Twitter started to get interesting with its track command and real time search service.  It's easy to imagine the Identi.ca XMPP bots getting more sophisticated with the ability to subscribe to users or create ad-hoc searches, but even this is only a beginning.

When XMPP is the API of microblogging, unimagined potential will be unleashed, which clever developers will be quick to make use of.  It may be that XMPP based microblogging takes the standard IM client we are all used to into new directions, the same way that clever use of AJAX has changed the Web browser.

Just think of what great things developers will do with the extensibility of XMPP.  No longer would they have to wait for Twitter or Identi.ca to implement ideas like hash tags.  They could extend the protocol with their own creations just by publishing in a new namespace; the service wouldn't care because this is the normal behavior of the XMPP protocol.

It makes me excited just thinking about it.

## XMPP's Drawbacks

The world of XMPP is not perfect.  The XMPP servers and clients are young and growing, and this can cause some [problems](http://metajack.im/2008/08/26/choosing-an-xmpp-server/).  The XMPP protocol is also alien to a world that has grown up on HTTP.  Better and more mature code as well as improved documentation will remedy much of this problem.  As XMPP gains importance in the world, more people will learn and understand it and transfer their knowledge to others.  It wasn't that long ago that developing Web applications was arcane, and it won't be long before developing XMPP applications is common.  We are seeing this already with [Gnip](http://www.gnipcentral.com/), [Yammer](http://www.yammer.com), and [Chesspark](http://www.chesspark.com).

Unlike the polling limitations of HTTP, these XMPP flaws are temporary and correctible.  We may yet discover new flaws, but the community behind XMPP is quite clever, and I'm sure they will handle these just fine, just as the HTTP community improved their protocol as issues were discovered.

## Protocols Live Together

XMPP and HTTP aren't mutually exclusive.  They solve different problems and they work quite well together.  I'm not advocating that HTTP be completely removed from microblogging.  There are several areas where it is exactly right.

You wouldn't want to replace the experience of browsing around looking for interesting people with XMPP.  The Web has already solved this quite well, and XMPP strengths do not add much value here.  Maybe this will change as people do more interesting things with XMPP.

Many devices won't speak XMPP for some time, and the Web is ubiquitous.  HTTP will be needed to bridge this gap for the foreseeable future.  

The Web is also a very convenient interface for experimentation and visualization, and I expect new ideas will continue to be prototyped there even if they are built on top of XMPP APIs.

## "Let's Do It"

Stefan has the right attitude.  We should not wait for the world to discover how great XMPP is for microblogging.  We should advocate our technology to those building new services and start building our own experiments.  It seems to me that microblogging could be the killer app for XMPP.
