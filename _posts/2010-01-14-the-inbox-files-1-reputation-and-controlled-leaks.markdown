---
layout: post
title: "The Inbox Files #1: Reputation and Controlled Leaks"
tags: [xmpp, jabber, xep, presence, reputation]
time: "21:34"
extended: ":EXTENDED:"
---

People are finding new ways to use XMPP every day. Sometimes these
new uses get documented and presented to the community for
consideration. These new [XMPP Extension Proposals
(XEPs)](http://xmpp.org/extensions/) are placed in the [extensions
inbox](http://xmpp.org/extensions/inbox/) while they go through the
initial review process. 

This series of blog posts will highlight recent inbox sightings. If
you'd like to comment on these, please feel free to do so here in the
comments, but I encourage everyone with feedback to join the
[XMPP standards
list](http://mail.jabber.org/mailman/listinfo/standards) and
participate there.

:EXTENDED:

## Entity Reputation

[Peter Saint-Andre](http://stpeter.im) has written a proposal for
communicating reputation of various XMPP entities, [Entity
Reputation](http://xmpp.org/extensions/inbox/reputation.html). Peter
writes:

> The public XMPP network might benefit from instituting a reputation
> system for servers, for end users, or both. The benefits might
> include fast blacklisting of rogue servers and other bad actors,
> differential quality of service based on reputation, delayed entry
> to Multi-User Chat rooms for low-reputation users, integration
> with Privacy Lists, and the like.

For the most part, reputation in XMPP systems is done explicitly by
adding and removing people from your roster. As more and more publicly
accessible services appear, such as chat rooms or game servers, it
will become necessary to assist users in better controlling
information when the roster isn't sufficient.

The suggested mechanic is an innocent until proven guilty system that
awards points for positive and negative actions. For example, a server
might get five points for requiring CAPTCHAs on registration, and a
user might have a reputation factor that is affected by the reputation
of their friends.

## Presence De-Cloaking

The [Presence
De-Cloaking](http://xmpp.org/extensions/inbox/decloak.html) proposal
is a bit more complicated. Essentially, it is sometimes necessary to
allow deliberate presence leaks, and this is an extension to allow
entities to request such leaks. It was authored by Simon McVittie of
[Collabora](http://collabora.co.uk).

The example mentioned in the proposal is when communicating between
SIP and XMPP Jingle, where clients shouldn't need to exchange presence
before communicating, but where communication needs knowledge of a
user's resource in order to take place.

It seems like a rather simple and useful extension that boils down
to an entity asking for a direct presence notification.

As with every new proposal, it will gather feedback from the community
and be presented to the [XSF Council](http://xmpp.org/council/), who
will decide whether it needs more work or is ready to begin the
standards process. There are currently 274 XEPs at the time of this
writing. Which one will be number 275?
