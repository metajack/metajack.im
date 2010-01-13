---
layout: post
title: Even Apple Uses XMPP
tags: [apple, xmpp, jabber, code, twisted, idavoll, jabberd2, osx]
time: "00:22"
extended: ":EXTENDED:"
---

[Ralph Meijer](http://ralphm.net/) recently informed me that a few of
his projects were shipping with Apple's OS X and OS X Server
products. It turns out that Apple keeps a rather [detailed
list](http://www.apple.com/opensource/) of the open source and free
software projects that are used by various parts of their tools.

Here are the XMPP-related projects on the list:

* [Twisted](http://twistedmatrix.com) Words, the IM protocol parts of
  the Twisted framework, which include XMPP support
* [Wokkel](http://wokkel.ik.nu/), the next-generation XMPP support
  for Twisted and my favorite way to hack XMPP in Python
* [Idavoll](http://idavoll.ik.nu/), the Twisted and Wokkel based XMPP
  pubsub server (used by Apple's NotificationServer)
* [jabberd2](http://jabberd2.xiaoka.com/), a well known XMPP server
  (used by Apple's ChatServer
* [xmpp4r](http://home.gna.org/xmpp4r/), the Ruby XMPP library
  (included as part of RubyOnRails)

Some of these seem to be included only with OS X Server or the
developer tools, but it's great to see Apple shipping so much XMPP
software in their stack. Apple also has plenty of proprietary XMPP
tools as well. For example, iChat is a fairly capable XMPP client.

Let's hope the trend continues!
