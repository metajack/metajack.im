---
layout: post
title: Twitter's Failures Are Not XMPP's Failures
tags: [friendfeed, identi.ca, jabber, sup, twitter, xmpp]
time: "09:42"
extended: ":EXTENDED:"
---

I came across [this post](http://robert.accettura.com/blog/2008/08/28/a-look-at-simple-update-protocol-sup/) by [Robert Accettura](http://robert.accettura.com/) while I was reading about FriendFeed's new [Simple Update Protocol (SUP)](http://blog.friendfeed.com/2008/08/simple-update-protocol-fetch-updates.html).  I have seen his view echoed elsewhere that XMPP is hard to implement, resource intensive, or inappropriate.  Their evidence for such claims is "look at Twitter's problems".  Twitter's, and others', failures are not XMPP's failures.

## XMPP's Promise

Unlike SUP, which FriendFeed is hoping gives them sub-10 minute latency in feed updates, XMPP promises near-zero latency.  Very low latency is an extremely useful feature.  It is the difference between your microblogging client giving you updates in big batches every N minutes and giving you updates in a natural stream as they happen.

For many, including myself, microblogging without XMPP is not very interesting.  The large polling intervals lock conversations into a weird, unnatural rhythm.  I don't think anyone predicted that low latency would be such a powerful feature for microblogging, but we sure miss it now that it is gone from Twitter.

## The Same Mistakes Over Again

Twitter's stability problems have been widely reported, and likely result from many factors.  Their issues with XMPP are fairly well known.  They made the mistake of making their first XMPP bot a normal user on an XMPP server.  This doesn't scale, as I have [written before](http://metajack.im/2008/08/04/thoughts-on-scalable-xmpp-bots/).

The issue with this design is well known in the XMPP community; for example, see these [two](http://blogs.openaether.org/?p=52) [posts](http://blogs.openaether.org/?p=110) from 2005.

I was quite surprised to see [Identi.ca](http://identi.ca) repeat these same mistakes.  It was surprising because the early Twitter issues with XMPP had been talked about.  It was surprising because Identi.ca had managed to attract almost everyone in the XMPP community as users of the service.  And it was surprising because [Evan](http://identi.ca/evan), mere months ago, was at the [XMPP Summit](http://www.xmpp.org/summit/summit5.shtml) along with Blaine Cook, formerly of Twitter, and these exact issues were brought up many times.

## It's Not XMPP's Fault

It's not that XMPP is not up to the job; people just keep making the same mistakes while trying to implement it.  I think this happens for a number of reasons.

* XMPP is well documented as a protocol, but documentation about how to use it and how pieces fit together is scarce.  Maybe the upcoming book will help.  There was also much discussion of *informational* XEPs to supplement the protocol definitions.  This will improve over time.
* XMPP software is still very young, and [it shows](http://metajack.im/2008/08/26/choosing-an-xmpp-server/).  It's ready for prime time, but one has to be on the lookout for bugs and ready to deal with them when they are found.  Unlike Web servers which have been tried and tested for many years, XMPP servers are all fairly new projects.  They are only just now coming into widespread use, and there are bound to be some growing pains.  None of these issues are related to XMPP as a protocol.
* XMPP is very different from HTTP.  Many people understand HTTP, and many developers have never used anything else.  XMPP is a world apart from HTTP.  REST services are built upon frameworks where the lifetime of the code is a single HTTP request.  XMPP services live indefinitely (one hopes), and this is a quite different problem.

Documentation will improve, software will mature, and people will become more familiar with XMPP.  Such is the case with all new technology. 

Do not listen to those who equate a service failure like Twitter's with a failure of the underlying technology.  It is not Ruby or Rails' fault that Twitter experiences downtime, and it is not XMPP's fault that Identi.ca has not managed to keep the public facing XMPP feeds reliable.  XMPP is a powerful technology that will affect the Web in many wonderful ways, as we are just starting to realize.  Some people have failed trying to make clever use of it, but many others have succeeded.  So can you.

:EXTENDED:


