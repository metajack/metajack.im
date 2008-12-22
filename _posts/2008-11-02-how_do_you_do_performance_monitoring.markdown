---
layout: post
title: How Do You Do Performance Monitoring?
tags: [code, erlang]
time: "20:29"
extended: ":EXTENDED:"
---

My team and I spent a lot of time investigating, monitoring, and tuning performance at [Chesspark](http://www.chesspark.com).  We had to build a lot of our own tools for this such as our [database profiler](http://metajack.im/2007/07/25/do-you-know-what-your-database-is-doing/index.html), and I suspect that most other people doing similar work have their own methods and tools.  I was therefore thrilled to find a nice discussion of various methods and ideas for doing this on the [Erlang questions](http://www.erlang.org/mailman/listinfo/erlang-questions) mailing list.

Don't let the fact that the discussion is among Erlang developers scare you off.  Erlang is not magic, and these ideas are pretty applicable anywhere if you put your mind to it.  For example, years ago I wrote a thread library in C for [Icecast](http://www.icecast.org) which detected deadlocks live, monitored lock contention, and allowed breaking locks and other administrative functions via a telnet interface into the running server.  If that can be done in C, then surely we can think of some extremely clever things in Python, Ruby, Erlang, and other languages.  That's not even taking into account the hugely powerful frameworks that can make this easy like [Twisted](http://www.twistedmatrix.com).

The full thread starts [here](http://www.erlang.org/pipermail/erlang-questions/2008-November/039538.html).  Happy reading!

:EXTENDED:


