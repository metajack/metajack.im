---
layout: post
title: Tape Your Stuff to the Web
tags: [python, twisted, tape, xmpp, javascript, jabber]
time: "10:40"
extended: ":EXTENDED:"
---

I work on a lot of JavaScript projects that make heavy use of AJAX.
Most of these need no server infrastructure except [reverse
proxies](http://en.wikipedia.org/wiki/Reverse_proxy) (due to
JavaScript's [same origin
policy](http://en.wikipedia.org/wiki/Same_origin_policy)).  I got
tired of setting up [nginx](http://nginx.net) configuration files, so
I wrote a simple Web server that publishes the current directory to
the Web along with reverse proxies.  I call it
[Tape](http://github.com/metajack/tape/tree/master) because I use it
to tape my stuff to the Web.

Tape is extremely easy to use.  Just type `tape`, and the current
directory is accessible via `http://localhost:8273` (8273 for
t-a-p-e).  Want to proxy your local
[BOSH](http://www.xmpp.org/tech/bosh.shtml) connection manager? Type
`tape -P /xmpp-httpbind=http://localhost:5280/xmpp-httpbind` and go!
You can also drop a `.taperc` file with proxy information into the
current directory and Tape will use that so you don't have to type
much.

Tape is inspired by [SproutCore's](http://www.sproutcore.com)
`sc-server` command.  While reading the change logs for SproutCore, I
noticed that this command recently got reverse proxy support. That
seemed like it would be incredibly useful for me, and Tape was born.

Tape is written in [Python](http://www.python.org) and makes use of
[Twisted's](http://www.twistedmatrix.com) Web server features.  It
clocks in at a little over 150 lines of code.

This is going to my make development work flow so much simpler.  I hope
it will help you as well.
