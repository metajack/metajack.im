---
layout: post
title: XMPP Server Portability Improving
tags: [xmpp, jabber, xep]
time: "17:46"
extended: ":EXTENDED:"
---

One of the many things being worked on as
[jabber.org](http://jabber.org) transitions to [Isode
M-Link](http://www.isode.com/products/m-link.html) is a specification
for exchanging user, roster, and other XMPP server data between
different implementations. The specification, [Portable Import/Export
Format for XMPP-IM Servers](http://xmpp.org/extensions/xep-0227.html)
is currently in its second last call.

This means that once all the servers have support for this, you'll be
able to move from one XMPP server to another very easily. Previously
this required writing custom migration scripts or hacking the code;
you can read about Chesspark's [move to
ejabberd](http://metajack.im/2008/08/27/migrating-to-ejabberd-the-gory-details/),
where my team went through such a migration. If only this had been
around back then, it might have saved us some time.

Another benefit of this, is that individual hackers will write import
and export programs instead of migration assistants between specific
implementations.

The current specification covers hosts, users, rosters, private XML
storage, offline messages, vCards, privacy lists, and incoming
subscription requests. Unfortunately, it doesn't include multi-user
chat rooms or publish-subscribe nodes (PEP or otherwise). I'm sure
these can be added as extensions, but it seems that those things are
all that is missing for this to be a very complete format that will
last for quite a while.

I'm not sure which of the server teams are working on implementations
of this, but since [Waqas](http://identi.ca/zeen) is one of the
authors, you can bet that [Prosody](http://prosody.im) will be
supporting this.
