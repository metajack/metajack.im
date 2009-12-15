---
layout: post
title: A New Generation of Search Tools
tags: [riak, dynamo, solr, lucene, sphinx, couchdb]
time: "09:38"
extended: ":EXTENDED:"
---

Most search functionality is powered by full-text indices. These
indices store information about which documents contain which
terms. The technology involved is quite old and simple to understand,
but the implementation details are a minefield of
complexity. Unfortunately, most implementations were built to solve a
specific class of problems and are having trouble meeting the
demanding needs of new applications. A new generation of indexing
systems is here, heralded by [Basho](http://www.basho.com)'s [Riak 
Search](http://www.basho.com/riaksearch.html).

:EXTENDED:

Software like Lucene, Solr, and Sphinx are optimized for class of
problems that doesn't always match up to an application's
requirements. They work very well when the document set they index
doesn't change very much or very often. Adding new documents to the
system is expensive. They have highly sophisticated on-disk data
structures that provide high query performance at the cost of
expensive modification.

For example, [Sphinx](http://www.sphinxsearch.com) has limited support
for adding new documents to a running system. From their [own
documentation](http://www.sphinxsearch.com/docs/current.html#live-updates):

> There's a frequent situation when the total dataset is too big to be reindexed from scratch often, but the amount of new records is rather small. Example: a forum with a 1,000,000 archived posts, but only 1,000 new posts per day. 

A typical use of Sphinx is to re-index all the content every day. It
can re-index very, very fast, but this means that the latency of
a new document being available for searching is a day. This may work
for many applications, but most users will expect new content to be
searchable immediately.

[Solr](http://lucene.apache.org/solr/) has sophisticated replication
and index merging, but it doesn't fare very well either for high
volume updates.  There is a significant lag between the time a
document is sent to the indexer and the time the index reflects this
new content.  Making this lag small has serious performance
consequences, and I know of few sites who can manage under 5 minutes;
most probably do merges hourly, daily, etc.

The more data you have, the worse these properties become. The bigger
your index, the longer it will take to merge. This leads many
applications to shard their search indexes in the same way that
high-traffic sites shard their databases. Solr has some limited
support for this built-in, but for the most part, it is a complex task
left up to the application developer.

This is not to say that these projects are poor; on the contrary, they
are quite good at what they are made for, and contain many components
that are generally useful. Many high-profile sites use them to great
success. However, for applications with high volumes of new content,
low latency requirements, or massive amounts of data, these tools are
a poor fit.

The world needs something better.

The problems I outline above with traditional indexing systems are
problems that I face every day at
[Collecta](http://www.collecta.com). We have massive volumes of new
data rocketing into our system, and we keep all this data on hand for
quite a while. In order to launch quickly and begin iterating, there
wasn't time to invent a new indexing system. We knew the limitations
of what we had and planned accordingly, bootstrapping technologically
as opposed to financially. 

Indexing at Collecta is there to provide historical context; it is
only part of our search technology. Our real-time technology is
powered by streaming (using [XMPP](http://www.xmpp.org)), not
indices. As far as I'm aware, we are the only real-time company that
is not based on indexing systems, and that fact probably explains why
our search results appear in fractions of a second after, not minutes
after, content is published.

Our users would not be impressed if the results page showed them
nothing until the next time someone mentioned their query term, so we
store a historical archive and index it for queries. Unfortunately, the
traditional indexing systems fall well short of our needs.

We need something better.

I've been following the NoSQL community for some time. Collecta was an
early adopter of [CouchDB](http://www.couchdb.org) and an early customer of
[Cloudant](http://www.cloudant.com). Earlier this year, I began to
plan for the development of a new indexing system to better meet our
needs. That's about the time I first met [Justin
Sheehy](http://twitter.com/justinsheehy) of Basho.

I had begun to think about using a
[Dynamo](http://en.wikipedia.org/wiki/Dynamo_(storage_system)-like
system as a basis for a new index. It had a lot of desireable
properties that I wanted. Specifically, trading off consistency for
search indexes makes the most sense.  We already have to live with
this trade-off with the other systems which are replicated, even
though those systems were not designed upfront with that trade-off in
mind.

When I first heard of Riak, I called Justin to learn more. In the
course of our conversation, I shared my ideas about a new indexing
system, and I asked if such a thing could be built on top of Riak.  We
had a fruitful conversation and came up with a lot of interesting
ideas.

Several weeks later, Justin told me that [John
Muellerleile](http://twitter.com/jrecursive) was leading a team at
Basho that had started experimentally building such a system, and it
was showing some promise. What followed was a lot of back and forth on
requirements, ideas, and demos over a period of a few months. Each
step of the way, we were all growing excited about the possibilities.

The end result of this effort is Riak Search, a new Basho product that
should mark the next era of indexing system design.  Collecta has
gotten a solution to several large pain points, not the least of which
is that Riak Search will save us a lot of money and time.  Basho has
gotten a new product and a new customer.

It gets even better! They even plan to open source a lot of it, a move
which we greatly encourage.

I think this technology will work its way in everywhere, and users
will get even better search experiences. Developers and administrators
will be pleased to stop fighting against the grain of the current
solutions and embrace the right tool for the job.
