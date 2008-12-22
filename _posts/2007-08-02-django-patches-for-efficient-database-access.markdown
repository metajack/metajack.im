---
layout: post
title: Django Patches for Efficient Database Access
tags: [code, database, django, optimization, python, sql]
time: "16:42"
extended: ":EXTENDED:"
---

In <a href="http://metajack.im/2007/07/25/do-you-know-what-your-database-is-doing/">Do You Know What Your Database Is Doing</a>, I mentioned that we had fixed several problems in Django that we discovered by using our query analyzer on <a href="http://www.chesspark.com/">Chesspark's</a> database logs.  Here's a list of the main tickets we've filed against Django.  The relevant patches and discussion are attached to the tickets.
<ul>
	<li><a href="http://code.djangoproject.com/ticket/3460">Ticket #3460: psycopg2 backend uses wrong isolation level</a> - This was the big one.  The database should be used in autocommit mode for single queries, and transactions should be used where necessary.  The python DB-API 2.0 mandates that the database wrapper automatically wrap transactions when not in autocommit mode, which leads to really inefficient database use when lots of single queries are used.  This is pretty much how every web app works, so fixing this will give you quite a database speed boost.</li>
	<li><a href="http://code.djangoproject.com/ticket/3459">Ticket #3459: initializing queries called too many times</a> - Django initialized the database by calling SET TIME ZONE and such for every query instead of only on connection setup.  This patch is now in the official tree.</li>
	<li><a href="http://code.djangoproject.com/ticket/3575">Ticket #3575: iexact uses wrong sql</a> - Django uses ILIKE instead of LOWER(col) = LOWER('blah').  This works fine, but ILIKE queries are unindexable.</li>
	<li><a href="http://code.djangoproject.com/ticket/4102">Ticket #4102: saving only changed fields</a> - Django saves every field on a call to modelobj.save() even if only one changed.  This creates nasty race conditions where two unrelated field updates can clobber each other.</li>
	<li><a href="http://code.djangoproject.com/ticket/3461">Ticket #3461: passing kwargs to the database wrapper</a> - Django doesn't pass cursor keyword args through to the database wrapper.  You need to do this if you wish to use dict cursors in the psycopg2 backend.</li>
</ul>
Some of these patches are specific to the postgresql_psycopg2 backend, but there may be similar problems with other backends since the efficiency issue is really a problem baked into DB-API 2.0 (for convenience).

:EXTENDED:


