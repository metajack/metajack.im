---
layout: post
title: Want $500?  Help Us Fix Jabberd2!
tags: [chesspark, code, jabber, jabberd2, xmpp]
time: "00:35"
extended: ":EXTENDED:"
---

We make heavy use of <a href="http://jabberd2.xiaoka.com/">jabberd2</a> 2.1.x at Chesspark.  <a href="http://jabberd2.xiaoka.com/wiki/People">smoku</a> has been making great progress taking this somewhat orphaned code base, maintaining it, and adding new features.  However there is a memory leak in the session manager component that neither he nor we have been able to find.

Please see the following MRTG graphs of memory usage to witness the problem:

<div style="text-align:center;"><img src="http://metajack.files.wordpress.com/2008/05/xmppmemory-month.png" alt="xmpp.memory-month.png" border="0" width="248" height="77" /></div>
<div style="text-align:center;"><img src="http://metajack.files.wordpress.com/2008/05/xmppmemory-year.png" alt="xmpp.memory-year.png" border="0" width="248" height="77" /></div>

The jumps in the graphs are server restarts.

The server is doing nothing abnormal.  It is handling some private xml storage, privacy lists, rosters and avatars in the normal ways and is backed by a Postgresql database.  The number of users online at any one time is in the hundreds.  Group chat traffic is fairly high with our Chesspark application since all games are also MUC rooms.

I am offering a bounty of $500 and a Chesspark t-shirt to the first person who fixes this leak.  I will also award a partial $100 bounty (and shirt) if you can write a reproduction script that will help others find and fix it.

The intention is to improve the jabberd2 code base, so your patch should be suitable for acceptance into the official tree.


:EXTENDED:


