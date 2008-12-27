---
layout: post
title: How About An HTTP Backend For Ejabberd?
tags: [couchdb, database, ejabberd, http, jabber, xmpp]
time: "22:23"
extended: ":EXTENDED:"
---

[Pedro](http://www.simplicidade.org/notes/archives/2008/11/rasputine.html) was trying to convince me this week that [ejabberd](http://www.ejabberd.im) needs an HTTP backend.  This would allow anyone to substitute a backend of their choice very easily, without having to code an ejabberd module in [Erlang](http://www.erlang.org).  It would be easy enough to make an HTTP server wrapper on top of any kind of database you wanted.

I wasn't entirely convinced at first, but as we talked about it more, we decided a [CouchDB](http://www.couchdb.org) backend would be really awesome.  This could actually serve two purposes.  The first is two enable CouchDB as a replacement backend for Erlang's Mnesia or traditional RDBMSes.  The second is that since the CouchDB API is so simple, it could be implemented by anything that speaks HTTP, assuming you didn't need any view logic.

I'm not sure that it's easy to do without the view logic without going through all the queries and trying it, but even if that's the case, a CouchDB backend would be a big win.  For starters, dealing with Mnesia is sort of a black art, and CouchDB is as simple as can be.

Someone has already created [mod_couch](http://www.cestari.info/2008/9/16/mod_couch-embedding-ecouch-client-for-couchdb-in-ejabberd) which enables ejabberd to use CouchDB via the [ecouch](http://code.google.com/p/ecouch/) library.  Now we just need the rest of it.

:EXTENDED:


