---
layout: post
title: The State of ejabberd Development
tags: [xmpp, jabber, erlang, ejabberd,  code]
time: "03:25"
extended: ":EXTENDED:"
---

While working on some recent [ejabberd](http://www.ejabberd.im)
patches, I ran into some strange problems. I finally tracked this down
to ejabberd's current trunk being a bit broken. After asking the core
developers, it turns out that they are in the middle of refactoring
the server to more fully use the
[exmpp](https://support.process-one.net/doc/display/EXMPP/exmpp+home)
library, and it will be a few months before trunk is once again
stabilized.

If you are used to working with ejabberd trunk for development and
testing, I recommend switching to the ejabberd-2.1.x branch until
trunk is back to its normal, fairly stable state.

I'm looking forward to seeing the result of the ejabberd team's labors.
