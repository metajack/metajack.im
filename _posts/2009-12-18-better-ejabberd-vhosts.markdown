---
layout: post
title: Better Ejabberd Vhosts
tags: [ejabberd, xmpp, jabber, erlang]
time: "23:12"
extended: ":EXTENDED:"
---

When Chesspark [migrated to
ejabberd](http://metajack.im/2008/08/27/migrating-to-ejabberd-the-gory-details/)
I explained how we modified ejabberd's authentication and SQL queries
to support storing users by their bare JIDs instead of just the local
parts (the foo part of foo@example.com). This let's each vhost in
ejabberd have a completely separate set of usernames as opposed to
make all usernames globally unique in the server.

Since I wrote that post, several people have asked me to share this
patch. I finally dug it out of the Chesspark code repository and
modified it for use with the recent 2.1.1 version of ejabberd. You can
find the patch included with [bug
EJAB-1131](https://support.process-one.net/browse/EJAB-1131).

Please note that I only modified the queries that were needed for
Chesspark. Not all modules' queries were transformed. Also, I didn't
make any changes to the MSSQL queries. However, if you look at the
patch, it should be extremely obvious how to make further
modifications if I missed something that you need. This patch has been
running well in production on Chesspark for over a year now, but I
have not fully tested this updated version.

Please let the ejabberd team know if you find this functionality
useful, and please let me know if you have any questions or if you run
into any problems.

