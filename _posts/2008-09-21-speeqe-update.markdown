---
layout: post
title: Speeqe Update
tags: [code, couchdb, django, ejabberd, group chat, jabber, muc, python, speeqe, xmpp]
time: "10:11"
extended: ":EXTENDED:"
---

[Speeqe](http://www.speeqe.com) development is progressing well.  We're really close to rolling out a new version with a new dashboard and some basic room history logging and search.  The big news, however, is that we've decided to make the whole thing an open source project and solicit help from the entire community.  We're putting together an initial release now, and it should be up at [code.stanziq.com](http://code.stanziq.com) soon.

Just to give you some idea of what to expect, here's an overview of the major pieces.  The Web application portion is written in Python using [Django](http://www.djangoproject.com).  The chat client is all JavaScript and based on [Strophe](http://code.stanziq.com/strophe) with the exception of a few bits of authentication which are handled in the Web app.  The Speeqe group chat service runs on ejabberd and persists history to [CouchDB](http://couchdb.org/) using a custom ejabberd component.

We are looking forward to your feedback and your help once the release is done!

:EXTENDED:


