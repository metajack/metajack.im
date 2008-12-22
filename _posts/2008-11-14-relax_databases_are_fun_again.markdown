---
layout: post
title: Relax! Databases Are Fun Again
tags: [couchdb, database, http, javascript, speeqe]
time: "15:13"
extended: ":EXTENDED:"
---

One of the most exciting projects around is [CouchDB](http://www.couchdb.org).  We've been playing with it for months, and we even used it in [Speeqe](http://www.speeqe.com) for group chat logging.  It is built like the Web; it scales like the Web; and it's as cool as the Web.

CouchDB is schema-less, [eventually consistent](http://www.allthingsdistributed.com/2007/12/eventually_consistent.html), and speaks HTTP and JSON natively.  One of the coolest pieces is the view layer, which uses MapReduce(http://en.wikipedia.org/wiki/Mapreduce) with map and reduce functions provided by JavaScript.

It replicates well in any topology you desire.  Finally, we have master-master replication that works well.  It can do this because it doesn't assume away the problem of data conflicts.  Instead, CouchDB provides tools to deal with conflicts.

Still not convinced?  CouchDB is a [peer-to-peer to application server](http://jchris.mfdz.com/posts/129) out of the box, thanks to its well done [Web interface](http://incubator.apache.org/couchdb/screenshots.html).  It also has the [coolest logo](http://incubator.apache.org/couchdb//img/couchdb-logo.png) of any project I've seen in quite some time.

So relax, and check out CouchDB.

:EXTENDED:


