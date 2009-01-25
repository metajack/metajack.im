---
layout: post
title: Some Thoughts on Logging
tags: [xmpp, jabber, amqp, spread, logging]
time: "23:30"
extended: ":EXTENDED:"
---

I'm not a huge fan of syslog.  It works well enough for logging on the
local host, but it has been extremely fragile for us when logging from
several hosts.  One thing we have been thinking about at
[Stanziq](http://stanziq.com) is trying to find a better solution.

There are tools like [Spread](http://spread.org/) or protocols like
[AMQP](http://amqp.org).  The basic idea behind these tools is
publish-subscribe, so it should be no surprise that
[XMPP](http://www.xmpp.org) fits this problem domain well.  This idea
came from [Ken](http:/identi.ca/kshep) during a conversation we had
about logging infrastructure; I was still looking at the list of
possible solutions when he made the obvious connection.

XMPP offers:

* publish subscribe semantics
* reliable delivery
* baked in presence
* multiple server implementations and client libraries in every
  language
* a whole suite of tools for managing commands, configuration, and
  extensibility

Some people might argue that solutions like AMQP are better, and for
this, I think [Peter](http://stpeter.im) has summed it up well in his
post on [AMQP and XMPP](https://stpeter.im/?p=2099).

I look forward to playing with a new XMPP based logging system, and
I'm sure I'll post more about it as it starts to materialize.
