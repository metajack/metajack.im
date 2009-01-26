---
layout: post
title: We Don't Need No Stinkin' Web Frameworks
tags: [xmpp, jabber, web]
time: "23:06"
extended: ":EXTENDED:"
---

Web frameworks can be nice, but they can also get in your way.  One of
the pleasant side effects of implementing more and more functionality
over XMPP is that we've eliminated the need for Web frameworks at
[Stanziq](http://www.stanziq.com).  This is extremely liberating.

How do we survive without them?  Here are some of the ways:

* Web frameworks may offer a lot of functionality, but XMPP has a
  excellent, diverse set of extensions that offer a higher layer to
  application developers.  Web frameworks are still essentially stuck
  on basic protocol plus ad-hoc commands.  XMPP provides pubsub,
  presence, discovery, and much more.
* Communication is done via XMPP through
  [Strophe](http://code.stanziq.com/strophe) instead of polling
  a database or using work queues.  This is a step up in efficiency.
* Configuration is stored in pubsub nodes instead of relational
  databases.  One awesome consequence of this is that all subscribers
  get instant notification of configuration changes, sort of like a
  broadcast `SIGHUP`.  
* Front end apps, administrative code, and internal utilities are all
  just JavaScript.  This makes them trivial to develop and test
  locally, and we don't need any special deployment code.
* The whole system is more decoupled because there is no middle
  interfacing layer.  The backend speaks XMPP, the frontend speaks
  XMPP, and they both use standard XMPP layer protocols to do work.

Of course, this isn't the right fit for every problem; Web frameworks
solve a lot of problem domains quite well.  For those areas where it
fails, it sure is nice to avoid the hassle and use an XMPP only stack.
