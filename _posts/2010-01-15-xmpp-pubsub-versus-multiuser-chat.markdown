---
layout: post
title: "XMPP Questions Answered: Pubsub versus Multi-User Chat"
tags: [xmpp, jabber, pubsub, muc]
time: "22:28"
extended: ":EXTENDED:"
---

Someone recently asked me this question via e-mail:

> I have failed to find a good explanation of how pubsub is different
> from multi-user chat. Are they both basically a way to broadcast a
> message to everyone who has subscribed to a node / joined a room? Why
> use pubsub, when support for multi-user chat is more mature?

Pubsub and multi-user chat (MUC) are related extensions, although not
by lineage.  Had pubsub come first, you can bet that MUC would have
been implemented on top of those primitives, but sadly, MUC came
first, and we had no pubsub to guide us.

Whether you use one or the other of these extensions depends on which
particular features your particular applications needs. Each of the
extensions has its unique advantages and disadvantages.

## Pubsub Advantages

Publish-subscribe is a very generic system, used by many different
kinds of applications. The XMPP pubsub extension is similarly generic
and is usable for a wide variety of purposes. It assumes nothing about
the subscribers; they may be human, or they may be machines.

Pubsub nodes, unlike multi-user chat rooms, are arranged in a
tree-based hierarchy. This shape is often a more close match to a
given problem domain.

One of the benefits of the tree shape is that entities can subscribe
to non-leaf nodes of the tree, and events published below that node
can also be received.

Events can be published as notifications or as full payloads, and the
subscriber can choose which is most appropriate.

Retrieval of the publishing history is built in and fairly fine
grained.

The subscriber has more fine grained control over the delivery destination.

The basic feature set of pubsub is quite easy to implement, and the
core mechanics are quite simple to understand.

## Pubsub Disadvantages

Pubsub, by being so generic, is not optimized for specialized cases.

The pubsub extension is not nearly as old or as widely implemented as
MUC, and the support for features in both clients and servers varies
in quality and depth. Unlike MUC, it is not yet clear what the most
used features are, so one must shop around a bit when an advanced
feature is needed.

There is no special handling of presence built in. There are a few
proposed extensions to pubsub that may change this. For example, it
would sometimes be useful to limit delivery to available resources only.

Tooling for pubsub node creation and configuration is lacking. Tools
like [Switchboard](http://github.com/mojodna/switchboard) and
[Poetry](https://launchpad.net/poetry) do exist, but aren't fully
baked yet. MUC room creation and configuration is built in to most
XMPP clients already.

Pubsub has not built-in mechanism for subscribers to interact or find
each other.

## Multi-User Chat Advantages

Presence handling is built in to MUC at a low level. Presence is used
to signal joining and leaving of room, and presence changes can also
be shared with occupants of the room.

MUC is optimized for chat-related use cases and builds on the decades
of experience of previous chat systems, especially IRC.

All the common moderation and administration features necessary in a
collaborative environment are supported - kicking, banning, and
various privilege levels.

MUC already has many implementations, both of clients and of
servers. It is one of the oldest XMPP extensions, and as such, is
quite mature and robust.

Occupants in MUC rooms can interact with each other, and MUC allows
for multiple levels of anonymity to be used as well as private communication.


## Multi-User Chat Disadvantages

Groups of people chatting is the bread and butter of MUC, and MUC is
highly optimized for this use case. For example, most MUC servers will
automatically send conversation history to every new occupant and
generate human-readable messages for most administrative actions. It's
possible, and common, to have bots as room occupants, but the
experience is designed for human consumption.

There is no way to organize chat rooms except as a flat hierarchy, and
there is no way to share configurations or participation across
collections of rooms. The one exception to this is that most servers
have a default configuration that is applied to all rooms on the
server.

All of these extra human-focused features and administration
capabilities make implementation more difficult. Unlike pubsub, MUC
implementations have a lot of edge cases to account for in order to be
user friendly and robust.

## Final Thoughts

At Chesspark we used MUC as the basis for distributing game
information because each game was also a chat room. Other companies,
like [Drop.io](http://drop.io) have also tread a similar path when the
access pattern was based around participants interacting with each
other.

You can add structured information on top of the chat primitives to
specialize MUC to a certain problem domain or to make it more computer
friendly.

At Collecta we used pubsub as the primitive because there was no
user-to-user interaction and only one publisher.

If you wanted to rebuild MUC on top of pubsub, you'd have to add
participant lists, presence handling, anonymity, and access
controls on top of what is provided. To build pubsub on top of MUC,
you'd be stripping away most of the interaction features and
human-centered design.

I think it comes down to which features are important for your
application. Most applications will probably map much more cleanly to
one or the other of these extensions, but in some cases, the choice
may be harder.

Please let me know in the comments if you've built a system on one of
these as well as why you chose one or the other.
