---
layout: post
title: An XMPP Microblogging Stack
tags: [jabber, microblogging, omb, openmicroblogging, pubsub, xmpp]
time: "09:00"
extended: ":EXTENDED:"
---

XMPP is [perfect for microblogging](http://metajack.im/2008/09/10/xmpp-microblogging-thoughts/), but so far no one is backing that up with an implementation.  Inspired by [Stefan's post](http://blog.jwchat.org/2008/09/09/xmpp-and-microblogging-lets-do-it/), a few of us are gearing up to take a crack at it.  I had separate conversations recently with [Anders](http://anders.conbere.org/) and [Matthew](http://matthewwild.co.uk) about what an XMPP microblogging service would look like, and I think the best way to kick off the project is to collect my thoughts here for others to comment on and discuss.   How would we build an XMPP microblogging stack?

:EXTENDED:

## The Requirements

What will this microblogging service do?

* It should be extremely fast and reliable.  Messages should never have noticeable latency in their delivery.  Instead of Laconica's method of writing to the database first, we will push through pubsub and have the database be a pubsub consumer, ensuring real time delivery is the highest priority.
* It should use [PEP](http://www.xmpp.org/extensions/xep-0163.html) for individual microblogs and [Pubsub](http://www.xmpp.org/extensions/xep-0060.html) for the aggregate server stream.  The aggregate stream will allow content aggregators and search engines easy access to the entire stream.  Access can be controlled if desired.
* It should use [Atom](http://en.wikipedia.org/wiki/Atom_(standard)) for individual messages.
* It should be extensible in the same way that XMPP is, by appending namespaced elements.  It may take some changes to the HTTP API that [laconica](http://loconi.ca) uses to make this work outside of the XMPP context.
* It should support the [Open Microblogging](http://openmicroblogging.org/) protocol.  [Evan](http://identi.ca/evan) has been doing great work promoting federated microblogging, and while OMB is still simple and HTTP based, there is little reason not to support it.  Perhaps we can help add the XMPP bits into the OMB specification as well.
* It should strive for HTTP API compatibility with laconica, so that existing developers can transition smoothly to the superior XMPP API when they need faster delivery or more features.
* It should be accessible via Pubsub/PEP as well as via a special component that will interact with standard chat messages.  The latter will be equivalent to the simplified XMPP API that [Identi.ca](http://identi.ca) currently uses.
* The APIs should support follow/unfollow, track, and direct messaging.  XMPP has this baked in, but
the simplified XMPP API and the HTTP API will need this added.
* Hash tags and other extensions should be handled correctly in appended namespaces, not by abusing the content field.

I'm sure we will think of more, but I think this covers the basics.  Future additions that come to mind are creating a microformat for Web based service discovery and the ability to point to a canonical microblog location with PEP if you have multiple Jabber IDs.

## The Design

The XMPP API will leverage existing XEPs for core functionality.

* Publishing to your microblog is accomplished by publishing to a PEP node.  The node you publish to should probably be configurable so that users can have multiple microblogs.  The node names were discussed at length at the [XMPP Summit](http://www.xmpp.org/summit/summit5.shtml), and the big debate was whether to use HTTP URLs as the name or to use a more opaque identifier.
* Items are in Atom format, and can be extended with new namespaces if necessary.
* Subscribing to someone's PEP feed requires sending [entity capabilities](http://www.xmpp.org/extensions/xep-0115.html) in a presence stanza to the person.  As new entries are published, the subscribing user will be notified immediately.
* Querying for historic entries is done via pubsub as well. See ["Retrieve Items From a Node"](http://www.xmpp.org/extensions/xep-0060.html#subscriber-retrieve).

We'll be trying not to add much to the HTTP API to maintain close compatibility, so I won't discuss that here.  Most HTTP API operations will just be converted into their equivalent pubsub operations.

The Web site will be designed similarly to Laconica.  Items will be read from the database to create the pages, and [memcached](http://www.danga.com/memcached/) will be used to make it fast.  The main difference is that [Strophe](http://code.stanziq.com/strophe) will be used to update the page in real time.

## The Implementation

* The implementation will be fully open source.
* ejabberd already has mod_pubsub and mod_cap.  We need to write something that aggregates the stream at a minimum.
* For the HTTP API, mod_http in ejabberd could be used, or we could go with a traditional Web stack like [Django](http://www.djangoproject.com).
* For the Web site itself, a normal Web stack will be used.  Strophe will be used for XMPP interaction to facilitate real time updates, and [jQuery](http://jquery.com/) will be used for DOM manipulation and effects.
* Items will persist to storage, but storage will be a consumer of the pubsub feed instead its provider as in Laconica.  Possible choices for storage backends are [CouchDB](http://incubator.apache.org/couchdb/), Amazon's [Simple DB](http://www.amazon.com/gp/browse.html?node=342335011), or something else.  Traditional RDBMSes are not appropriate for this task.  The data is not heavily relational.

I know that Anders is pushing for [Rabbiter](http://anders.conbere.org/journal/rabbiter-open-federated-pubsub-server/), so we will be discussing that I'm sure.  What choices we make for various pieces isn't really that important, although I will probably advocate for Django and CouchDB at the start.

## Aggregation

We also plan to develop some aggregation tools.  These will consume public feeds from other OMBs vis pubsub or HTTP push and offer them up as combined pubsub feeds.  This will be the XMPP equivalent of [Planet](http://www.planetplanet.org/).

## Looking For Feedback

I talked to several people at [BearHugCamp](http://metajack.im/2008/09/13/bearhugcamp-for-those-who-missed-it/) about this, and people seemed quite excited.  We'd love more feedback from the OMB and XMPP communities these ideas.  Please leave a comment!
