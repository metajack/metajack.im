---
layout: post
title: Make Your Twisted XMPP Apps Scream
tags: [xmpp, jabber, twisted, python, code, xml, c]
time: "23:50"
extended: ":EXTENDED:"
---

XML serialization tends to be the most expensive part of many
[XMPP](http://www.xmpp.org) applications, and [Twisted
Python](http://www.twistedmatrix.com) apps are no exception.  Now
you're Twisted apps can scream with a new [C based XML serializer for
Twisted](http://github.com/metajack/cserialize).

*Note:* To speed up [ejabberd](http://www.ejabberd.im), please see
[Speed Up Ejabberd](http://metajack.im/2009/01/18/speed-up-ejabberd/),
which talks about a similar solution for [Erlang](http://www.erlang.org).

The standard serialization code in Twisted can process approximately
2,100 elements per second on my Macbook Pro.  It's not great, but it's
a reasonable start.

A few years ago my team and I spent a few days improving this code.
The result was a [pair of
patches](http://twistedmatrix.com/trac/ticket/2477) that traded off
memory for speed by caching serialized fragments.  This code can
process about 3,150 elements per second on the same machine.  This is
an improvement factor of 1.5.

Last week, the Twisted team improved this work in preparation for
merging it into the code base.  They managed to achieve about 3,700
elements per second - an improvement factor of 1.75x over the original
code.

While they were working on this, I realized that it would be fairly
easy to write a C module that could serialize the Twisted XML objects
directly.  It took a little longer than expected, but you can find
such a serializer at the [cserialize GitHub
page](http://github.com/metajack/cserialize).  This code achieves over
7,500 elements per second, which is a factor of 3.5x faster than the
original code.  

I've yet to really optimize this code, so I think more
gains can be made.  I'm hopeful that I can make it about twice as fast
as it is now.  My original version, which was missing namespace
support, was about 15 times faster than the original Python code.  I'm
not quite sure where the slow down came from, but as soon as I figure
out how to profile Python C modules, I'll track it down.

This code is fresh, but it passes almost all of the Twisted tests.
The few that don't pass appear to be legitimate bugs in the test
cases, not the serialization code.

I've created [bug #3633](http://twistedmatrix.com/trac/ticket/3633) to
try and get this integrated upstream.  In the meantime, we'll be
enjoying our faster games at [Chesspark](http://www.chesspark.com) and
speedier searches at [Stanziq](http://www.stanziq.com).
