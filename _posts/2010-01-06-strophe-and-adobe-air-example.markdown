---
layout: post
title: Strophe and Adobe Air Example
tags: [adobe air, strophe, javascript, xmpp, jabber, code]
time: "13:38"
extended: ":EXTENDED:"
---

Ever wanted to use [Strophe.js](http://code.stanziq.com/strophe) to make
desktop applications? One way to do this is to use Adobe Air, which
works perfectly with Strophe.

[Joshua Lim](http://josian.wordpress.com) has written up a nice
[Strophe on
Air](http://josian.wordpress.com/2009/04/20/my-first-strophe-air-app/)
example to show people exactly how to do this.

I've also done a few experiments with this, and it turns out that
making Strophe applications with Air is actually even easier than with
standard browsers. The Air environment doesn't restrict access to the
same domain, so you don't need to use any proxies or Flash-based
workarounds for the HTTP binding.

You can also convert any of the current Strophe.js examples to an Air
application but creating an appropriate application description XML
file for them and switching the BOSH endpoint to be a full URL to a
running HTTP binding service.

Hopefully someone will do a similar write up for
[Titanium](http://www.appcelerator.com/products/titanium-desktop/).
