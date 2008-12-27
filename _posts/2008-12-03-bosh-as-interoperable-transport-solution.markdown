---
layout: post
title: BOSH As Interoperable Transport Solution
tags: [bosh, jabber, xmpp]
time: "14:24"
extended: ":EXTENDED:"
---

Over on the [Not Invented Here](http://nih.blogspot.com/) blog, Lisa [talks](http://nih.blogspot.com/2008/12/im-following-up-on-my-last-rant-on.html) about [BOSH](http://www.xmpp.org/extensions/xep-0124.html):

> If it really becomes universally supported in servers, then we could write any new application on top of XMPP and it will work over HTTP as well as natively over TCP. Now that's interoperability! 

Many people are starting to do exactly this.  Why provide two transports when one will do?  You can even use the same API to interact with XMPP over TCP as with HTTP; just see [Strophe](http://code.stanziq.com/strophe) for an example.

Another thing to note is that BOSH is split up into two parts.  One part just sets up a two way XML stream; the second part puts XMPP semantics on top of this.  I don't believe any of the BOSH implementations currently support the non-XMPP BOSH, but I'm sure they could be easily modified to do so.

This is yet another reason to use BOSH and XMPP over other Comet-y techniques.

:EXTENDED:


