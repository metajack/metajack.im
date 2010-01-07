---
layout: post
title: Strophe Setup Tutorial with ejabberd and nginx
tags: [ejabberd, nginx, strophe, javascript, code, xmpp, jabber]
time: "15:04"
extended: ":EXTENDED:"
---

[Anders Conbere](http://anders.conbere.org/) has posted a [lengthy
tutorial](http://anders.conbere.org/blog/2009/09/29/get_xmpp_-_bosh_working_with_ejabberd_firefox_and_strophe/)
on getting [Strophe.js](http://code.stanziq.com/strophe) working in a
proxied setup using [nginx](http://nginx.org/) and
[ejabberd](http://www.ejabberd.im/). If you've been trying to get
started, this may help with what is probably the hardest part of the
process.

He does a good job of laying out what the major roadblocks are to
getting started:

> Yesterday I set about getting my own test environment running for
> developing some BOSH related apps I'm working on. This turned out to
> be a bit of a struggle as I ran into a variety of issues that I had
> no idea about. The basics seem easy, install an xmpp server that
> supports BOSH, get a BOSH client, use it to write a test app and
> have at it. But there are some small details to get in the
> way. First is that not all web browsers support making XHR from
> local files (Firefox tells me this is a security issue), so you'll
> need to host your development files on a local webserver. Second is
> that unless you want to set up a crossdomain policy (not difficult)
> you'll need to have the BOSH server running on the same domain and
> port as your development files are being hosted.

There are three chapters with similar content in [Professional XMPP
Programming](http://professionalxmpp.com). Chapter 3 deals with
getting an initial environment set up without proxies, using Flash to
get around cross-domain restrictions. Appendix B deals specifically
with setting up nginx, ejabberd,
[Punjab](http://code.stanziq.com/punjab),
[tape](http://github.com/metajack/tape), and dealing with Flash
crossdomain.xml files. Chapter 13 goes into details on configuring
things for load balancing or clustering with ejabberd, nginx, and
Punjab.


