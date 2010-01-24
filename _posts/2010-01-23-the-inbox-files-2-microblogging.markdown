---
layout: post
title: "The Inbox Files #2: Microblogging"
tags: [jabber, xmpp, microblogging, pep]
time: "21:52"
extended: ":EXTENDED:"
---

People are finding new ways to use XMPP every day. Sometimes these new
uses get documented and presented to the community for
consideration. These new [XMPP Extension Proposals
(XEPs)](http://xmpp.org/extensions/) are placed in the [extensions
inbox](http://xmpp.org/extensions/inbox/) while they go through the
initial review process. The Inbox Files reports on the latest
additions to the inbox. Today, I'll discuss [Microblogging over
XMPP](http://xmpp.org/extensions/inbox/microblogging.html)

:EXTENDED:

## Microblogging

This proposed XEP was originally added to the inbox well over a year
ago. Peter and Joe both wrote down a very simple proposal for how XMPP
microblogs might work.

Their proposal uses
[PEP](http://www.xmpp.org/extensions/xep-0163.html), a simplified and
personalized extension of [pubsub](http://xmpp.org/tech/pubsub.shtml),
to store microblogs. Microblogs are discovered with standard service
discovery, and users can subscribe, publish, and receive events just
like with normal pubsub nodes. Atom, with some threading extensions,
is used for the content of posts.

One thing that I love about this XEP is that it is extremely short,
but fulfills most of the same features that microblogging systems
have. It doesn't take much to get some interesting applications on top
of the many tools XMPP already provides. Pubsub in particular is a
fundamental building block for an enormous number of applications.

There are some real issues with this XEP that still need addressing,
the main one being that users should be able to have multiple
microblogs or point to microblogs that are hosted elsewhere (like on
Twitter or [Identica](http://identi.ca)).

A complete microblogging system in XMPP would need aggregation and
some extra Atom extensions for various kinds of metadata. 

I've written about microblogging and XMPP before. If you're curious:

* [XMPP Microblogging
  Thoughts](http://metajack.im/2008/09/10/xmpp-microblogging-thoughts/)
* [An XMPP Microblogging
  Stack](http://metajack.im/2008/09/15/an-xmpp-microblogging-stack/)
