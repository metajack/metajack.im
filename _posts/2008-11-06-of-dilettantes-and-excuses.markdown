---
layout: post
title: Of Dilettantes And Excuses
tags: [gnip, jabber, startups, xmpp]
time: "10:02"
extended: ":EXTENDED:"
---

[XMPP](http://www.xmpp.org) is getting more and more popular.  Every day we see new companies and new projects capitalizing on the strengths of the protocol.  The downside of this popularity is that we must also put up with the dilettantes like [Twitter](http://twitter.com) and [Gnip](http://www.gnipcentral.com).  Like Twitter, Gnip has  [ceased its promising experiments](http://blog.gnipcentral.com/2008/11/03/winding-down-xmpp-for-now/) with XMPP.  Like Twitter, they [blame the technology](http://metajack.im/2008/09/03/twitters-failures-are-not-xmpps-failures/index.html) involved.



:EXTENDED:

## Own Up To Your Lack Of Commitment 

Startups are hard; no one is debating that.  If your plate is so full that promising experiments must be put on hold, then just say so.  Twitter had scaling issues to address, and with those in mind, perhaps it made sense for them to abandon XMPP.  Perhaps Gnip has some issues too which demand its attention at the expense of XMPP.  What is silly is the consistent fast talk of blaming XMPP or XMPP implementations.

We all know that XMPP implementations aren't perfect.  Web servers weren't (and still aren't) perfect either, but this never stopped [Yahoo](http://www.yahoo.com) or [Amazon](http://www.amazon.com) from utilizing the Web in new and interesting ways.  With only the so-called "immature" implementations, [Chesspark](http://www.chesspark.com) has managed to build something quite complex and robust.

The difference is that Yahoo, Amazon, and Chesspark are committed to their solutions, and Gnip is not committed to XMPP.  This is perfectly fine, but do us all a favor and own up to it instead of laying blame.

## Aren't The Customer's Right?

Gnip claims that XMPP accounts for most of their support burden.  This signals that many of their customers want to use XMPP.  Eric even [says](http://blog.gnipcentral.com/2008/11/03/winding-down-xmpp-for-now/#IDComment10396549) that these customers are "probably already running a web server".  If that's the case, and they still choose to use XMPP, doesn't that mean that taking XMPP away is just going to frustrate them?

Instead of treating your customers as incapable of setting up new servers or incapable of making the right technology decisions, perhaps you should help them out.  If [jabber.org](http://www.jabber.org) and [Google Talk](http://talk.google.com) accounts are being abused, don't allow them to be used.  If people need to set up their own servers, offer them some pointers to setup guides.

## The Easiest Solution

Other people have [written](http://code-bear.com/bearlog/2008/11/04/xmpp-ecosystem/) [about](http://www.stoweboyd.com/message/2008/11/gnip-dropping-x.html) [this](http://www.readwriteweb.com/archives/gnip_says_xmpp_ecosytem_too_ha.php) [too](https://stpeter.im/?p=2351).  Everyone has been concentrating on this idea that Gnip's customers should be running their own XMPP servers.  Instead of placing such a high burden on them, why doesn't Gnip just let people sign up for accounts on its own server?

Having an account on Gnip's XMPP server makes a lot of sense.  Gnip can tune the server to handle the high throughput, low latency data it wants to provide.  Gnip is in a much better position to understand how to do this than arbitrary customers.  Even if those customers set up their own servers, the servers all come configured for typical chat usage, not data streaming in high volumes.

It also costs Gnip no extra bandwidth.  They are sending these people a stream anyway, why not as a locally connected client as opposed to a federated one?

Finally, it's easy to write XMPP clients.  There are [tons of libraries](http://xmpp.org/software/libraries.shtml) for working with data as an XMPP client, and these libraries are in at least a dozen different languages.  Gnip's customers have easy access to and much documentation for working with data as an XMPP client.  After all, they probably have to write a client to talk to their server anyway; why involve a middle server?

## The Rest Will Keep Innovating

While Gnip and Twitter abandon XMPP, many others are doing exactly the opposite.  [Enjit](http://www.enjit.com) is providing a real time interface to [FriendFeed](http://www.friendfeed.com) via XMPP.  There are already people writing [clients](http://github.com/mojodna/fire_hydrant/tree/master) for Yahoo's FireEagle location services which use XMPP.  Don't forget [Identica](http://identi.ca) which is doing much of what Twitter gave up on, also via XMPP.

This is a high technology industry, and why anyone would abandon the best tools for real time communication is a mystery to me.  Just as [Graham](http://www.paulgraham.com/icad.html) lays out the case for different languages having different "power", I think the [same is true for protocols](http://metajack.im/2008/09/11/real-time-is-completely-different/).  I know I'll be sticking with the powerhouse, XMPP.
