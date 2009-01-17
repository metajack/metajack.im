---
layout: post
title: New Erlang, Ejabberd, and Twisted Words For Intrepid
tags: [ubuntu, intrepid, erlang, ejabberd, twisted, xmpp, jabber]
time: "22:00"
extended: ":EXTENDED:"
---

We've been preparing new some machines at
[Stanziq](http://stanziq.com) and I've had to build some custom
packages for various bits of our software stack.  I've made these
available on my [Launchpad
PPA](https://launchpad.net/~metajack/+archive).  I've updated the
`ejabberd-snapshot` package and added `erlang` and
`python-twisted-words` packages.

The new `ejabberd-snapshot` is built from trunk revision 1821.  There
are some great fixes for `mod_pubsub` in here.

Intrepid comes with [Erlang](http://www.erlang.org) version R12B-3,
but the latest is R12B-5.  There is at least one important fix in the
newest version that affects ejabberd users.  Thankfully, the
[Debian](http://www.debian.org) maintainers have already packaged it;
it just hasn't made it into intrepid.  Their package is now built in my PPA
so that all Ubuntu users may enjoy an updated Erlang.

Finally, `python-twisted-words` suffers from slow serialization of
XML.  There is an [open
bug](http://twistedmatrix.com/trac/ticket/2477) about this in the
Twisted Trac, but it hasn't yet been applied to trunk.  We've been
using it at [Chesspark](http://www.chesspark.com) for two years, and
it will speed up your Twisted XMPP code considerably if it does much
serialization.

Enjoy these packages!
