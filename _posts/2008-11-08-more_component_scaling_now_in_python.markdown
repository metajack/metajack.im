---
layout: post
title: More Component Scaling, Now In Python
tags: [code, jabber, python, twisted, xmpp]
time: "10:32"
extended: ":EXTENDED:"
---

[Ralph Meijer](http://ralphm.net) responded to yesterday's post about [component scaling](http://metajack.im/2008/11/07/xmpp-component-scaling/) with code.  It's a [Wokkel](http://wokkel.ik.nu) component that proxies and load balances other components.  The advantage of this code over [ejabberd's](http://www.ejabberd.im) solution is that it is server independent; it will work on whatever server supports the [component protocol](http://www.xmpp.org/extensions/xep-0114.html).

The code is available [here](http://wokkel.ik.nu/browser/sandbox/ralphm/component_lb.py).

As if we needed any more proof that Wokkel and [Twisted Python](http://twistedmatrix.com) were the best ways to write [XMPP](http://www.xmpp.org) software.  Pretty cool, Ralph!

:EXTENDED:


