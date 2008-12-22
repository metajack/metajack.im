---
layout: post
title: Thoughts On Scalable XMPP Bots
tags: [bots, chesspark, code, jabber, scalability, xmpp]
time: "11:25"
extended: ":EXTENDED:"
---

It used to be that chat bots were toy projects written by young programmers to impress their friends in their favorite IRC channel.  These days, some bots are much more ambitious projects.  For example, both <a href="http://identi.ca/">identi.ca</a> and <a href="http://twitter.com/">Twitter</a> are using XMPP bots to distribute messages to users in real-time.  At <a href="http://www.chesspark.com/">Chesspark</a>, we have chess playing bots that must be able to play hundreds of games at a time.  It's no longer good enough just to have a bot; now the bots have to scale.

<strong>Client Bots</strong>

The first step along the bot programmer's journey is to write the bot as an XMPP client.  Many client libraries already exist, and the client protocol is well understood.  It doesn't take long to have a working echo bot in any number of languages.

There is a huge problem with client bots - rosters.  If part of the client bot's functionality depends on subscribing to the presence of its users, the roster size becomes the limit to scalability.  There are two reasons for this.

First, querying large rosters from persistent storage is an expensive task for the XMPP server.  Many servers are written with the assumption that all rosters are fairly small.  Once rosters become tens of thousands of entries long, this starts to affect performance elsewhere in the system.

Second, a large roster means an enormous stanza in the connection startup.  As I've written before, <a href="http://metajack.im/2008/06/10/binary-data-is-xmpps-achilles-heel/">large stanzas are bad</a>.  Pretty much all processing will stop for the bot while it receives and deals with this stanza.  If that stanza takes more than a few seconds to receive, users will notice this delay when the bot starts up.

Both of these issues affect startup only.  It's not a big deal if your bot has 100% uptime, but this is unachievable.  Even worse, if you run into a crash bug, the bot can start to destroy performance of itself and of the server it is connected to.  In May of last year, this is what happened to Twitter as its bot passed the 40,000 roster item mark.

What can the bot developer do?  Rewrite the bot as a component.

<strong>Component Bots</strong>

A component is a trusted piece of an XMPP server that can send and receive arbitrary stanzas.  Components speak a <a href="http://www.xmpp.org/extensions/xep-0114.html">different protocol</a> to communicate with the server.  Because the name of a component is a domain (example: arbiter.chesspark.com), a component can pretend to be many users.  Any stanza addressed to user@component.server.com will be delivered to component.server.com no matter what the value is of 'user'.

Because the XMPP server has no idea what services a component will perform, it does not require a component to maintain a roster for any users it pretends to be.  This means that the large roster problem does not exist for components.

If the component still needs to keep track of user presence, it is easy to subscribe and handle subscription requests to and from users.  In most cases, the bot won't even need to keep track of this information.  Even if it needs to know the presence of all users, it can just put these values in memory as they change and send presence probes to get them on restart.

<strong>S2S Bots</strong>

It may turn out that your bot needs super-scalability; in that case, the next step is to have the bot speak the server to server (s2s) protocol directly, and pretend that it is an entire XMPP server.  There are several reasons why you might want to do this.

The XMPP component protocol does not currently provide for load balancing or clustering.   Some servers may allow this using extensions or by writing server specific components.  In order to horizontally scale a component, one must handle this scaling by implementing some inter-component protocol and then using a custom load balancer that speaks the componenent protocol to the server.  Since s2s connection endpoints are managed via DNS SRV records, an s2s bot can use DNS as a load balancer and only have to handle communication between the partitions of the bot. While this doesn't get you scaling by itself, it at least reduces the problem considerably.

In some cases, the XMPP server may be too much overhead if your service is essentially just an XMPP bot.  Why send traffic through a routing process inside a server if it is already known that it is for use externally?  Even small amounts of overhead can add up quickly at scale.  In terms of managing infrastructure alone, taking out an XMPP server from the equation saves a lot of work.

<strong>Further Thoughts
</strong>

We've built a lot of bots at Chesspark.  To date we have used client bots and component bots to achieve our goals, but in pursuit of high availability, we will need to address the single points of failure.  Speaking s2s or developing custom load balancing for XMPP components is on our agenda for the future.

<a href="http://thetofu.com/">Christopher</a> and I have a bunch of example code that we've been preparing showing how to implement XMPP bots in <a href="http://www.twistedmatrix.com/">Twisted Python</a>.  Look for some tutorials in the near future.

:EXTENDED:


