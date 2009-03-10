---
layout: post
title: XMPP Complexity Versus Sophistication
tags: [jabber, xmpp]
time: "20:59"
extended: ":EXTENDED:"
---

Outside of the XMPP community a perception seems to exist that XMPP is
too complex or too difficult, usually in reference to HTTP.  I don't
believe this is an accurate perception, and I've been wanting to
address it here for some time.  Of course, simpler systems can be
built, but in most cases, these simpler systems are missing critical
features such as security, extensibility, or maturity.  I think that
once these features are addressed, what you end up with will be
markedly similar to XMPP.

:EXTENDED:

## Security

The original XMPP protocol was not nearly as secure, and because of this,
much simpler.  The [IETF](http://www.ietf.org) required that we
address this issue when we went through the standardization process.
TLS, SASL, and other methods replaced ad-hoc SSL, plain text
authentication, and server dialback.  Any alternative protocol will
probably need to be similarly hardened.

[Jayson Vantuyl](http://souja.net/) recently talked about this on the
[CloudForum list](http://groups.google.com/group/cloudforum):

> XMPP comes with a built-in, non-optional security mechanism.  This is
> really going to have to be a part of any Cloud.  Passing around
> authentication tokens is lovely and all, but having it at the
> transport level just makes a lot more sense.  After all, it's what
> HTTP does.  XMPP just makes it a bit easier to work with because it's
> not optional, not an afterthought, and uniformly accessible without
> regard to which server you're using (e.g. extending HTTP auth isn't
> realistic given all the servers out there).

## Extensibility

I've seen several people mention recently that
[JSON](http://www.json.org/) might be a better encoding for something
like XMPP.  XML however, does offer several present day advantages.

* XML tools and libraries are well deployed, well tested, and pretty
  much ubiquitous.  JSON parsers are getting there, but still have a
  ways to go.  Also, a JSON parser would need to accept streaming
  data, and my guess is that few of them currently do, just as few XML
  parsers used to deal with such data.
* XML namespacing provides the core of XMPP's extensibility.  This
  does make the encoding more complex, but for good reason.  JSON
  would have to develop something similar, but I think the XML
  solution would look elegant in comparison.  It is easy to put new
  elements and attributes in existing ones.  How does one do this in
  a JSON array without breaking previous implementations?
* XML is human readable, making debugging easy.  This was a huge win
  for HTTP.  Many times on the XMPP lists, developers can post short
  snippets of wire traffic, and the problems are easily identified.
  Here JSON is on the same page, but binary encodings are not.

## Maturity

It may seem strange at first to talk of XMPP's maturity, but the fact
is that many clever minds have been thinking and working on it for a
decade.  Each implementation comes with bugs, but these are rapidly
disappearing as well, just as they did for HTTP.

A hypothetical new and simpler protocol would need to recreate a lot
of this work, especially in the area of publish-subscribe.  One thing
I've been very happy about with XMPP is that the hard work (designing
the protocol) has already been done.  I'm well equipped to create
plugins, fresh implementations, or bug fixes; protocols, on the other
hand, are quite hard to get right.

## Design versus Implementation

I think people desire something simpler so that it is easier to
implement, but they don't always realize that the hard part is not the
implementation, but the protocol design.  It is an incorrect
optimization in many cases to design for ease of implementation by
subtracting robustness or sophistication.

## XMPP is Beautiful and Getting Better

Once you get a connection established and authenticated, XMPP is
simple and beautiful.  With HTTP, getting to this point is fairly
trivial in 99% of cases, as authentication is usually ignored or that
sophistication is moved directly into the applications.

I think what people are frustrated by is deploying XMPP and dealing
with the strict security requirements.  

Deploying XMPP is getting better, just as HTTP did.  A decade ago,
getting Apache running was not huge fun.  Nowadays, almost everything
comes with a simple built in Web server.  It's not that HTTP is easy,
it's that the implementations and documentation for those
implementations improved dramatically.  XMPP is making huge strides on
these issues.

[Peter](http://stpeter.im), in the same email thread as Jayson above,
offered this:

> If your complaint against XMPP technologies is that the
> existing software implementations can be difficult to deploy, then the
> solution is not to throw out all of the work that has been done over the
> last ten years to harden and secure XMPP's core layers and also develop
> numerous extensions to that core. Instead, the solution is to build a
> slimmed-down implementation in one of your preferred code languages.

People are starting to do just this.  We have
[Wokkel](http://wokkel.ik.nu) (which will get folded into Twisted
Python), [Prosody](http://prosody.im) (written in Lua), and
[synapse](http://synapse.malkier.net/) (written in Ruby) already.
