---
layout: post
title: Some Thoughts on Serialization
tags: [xmpp, jabber, xml, amqp]
time: "20:00"
extended: ":EXTENDED:"
---

I've [written](http://metajack.im/2009/01/18/speed-up-ejabberd/)
[before](http://metajack.im/2009/01/26/make-your-twisted-xmpp-apps-scream/)
that XML serialization tends to be the main bottleneck in XMPP apps.
I haven't benchmarked other software stacks that involve
serialization, but I'm guessing it's expensive everywhere.  Here are
some thoughts on serialization that I've had recently.

* Eliminating serialization is better than making it faster.  This is
  an obvious statement, but getting rid of serialization is not always
  easy.

* The XMPP [component
  protocol](http://xmpp.org/extensions/xep-0114.html) adds two
  serialization steps in most cases.  One serialization to send data
  to the component over the socket and one for the components response
  back to the server.  If you want to avoid this extra work, the
  component logic should be implemented in a server native fashion
  such as an [ejabberd](http://www.ejabberd.im) module.

* Using XMPP over some other protocol stack will probably add
  serialization costs.  For example, you might implement an XMPP
  pubsub service on top of an [AMQP](http://www.amqp.org) based
  backend.  This means that you have an extra serialization cost of
  converting to the other protocol.
* As everyone optimizes their code, we'll see more and more native
  serialization plugins, application code that speaks server native
  data structures, and application code that passes around already
  serialized chunks (the original data off the wire).
  [Punjab](http://code.stanziq.com/punjab) with
  [cserialize](http://github.com/metajack/cserialize/tree/master) is
  an example of an application using a native serializer and passing
  around already serialized chunks.
