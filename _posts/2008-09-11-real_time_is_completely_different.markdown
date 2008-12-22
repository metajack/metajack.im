---
layout: post
title: Real Time Is Completely Different
tags: [http, jabber, latency, rest, xmpp]
time: "11:10"
extended: ":EXTENDED:"
---

Everyone knows that HTTP polling sucks.  [Roy Fielding](http://roy.gbiv.com) is right to [point out](http://roy.gbiv.com/untangled/2008/paper-tigers-and-hidden-dragons) that it doesn't have to be so bad.  His [paper tiger](http://roy.gbiv.com/untangled/2008/paper-tigers-and-hidden-dragons) post presents a clever representation for state changes on a system like [Flickr](http://flickr.com) which improve HTTP polling dramatically.  However, one thing that Roy appears to get wrong is that XMPP is not appropriate for large scale monitoring.  While HTTP polling can be improved, it cannot match the real time capabilities of XMPP.  XMPP is a win in this space because real time is important and because real time is completely different.

:EXTENDED:

## A Comparison

Roy's Flickr example is excellent.  His solution is appropriate for most uses and is extensible (see below on older state changes).  I'm going to use his example here even though there is an argument to be made that real time updates of Flickr information are unnecessary.  Microblogging has seen the [power of real time](http://metajack.im/2008/09/03/twitters-failures-are-not-xmpps-failures/), and I think other services could benefit from it as well.

### HTTP

In the HTTP example, a black and white image is generated that contains `N` pixels.  Each pixel represents whether a particular user's feed has new content.  This is a more clever and compact version of [FriendFeed's Simple Update Protocol (SUP)](http://blog.friendfeed.com/2008/08/simple-update-protocol-fetch-updates.html).  It allows one to poll a single URL to determine if some aggregated feed has been updated.

The problem is that polling is still involved.  In order to know whether a feed has changed, we still have to poll the URL.  How often we poll will be the minimum bound on the update latency.

To approach real time update notifications, we must poll an abusive amount.  If we want to get updates in less than 5 seconds, that's 12 requests a minute or 17,280 requests a day.  This is perfectly fine for someone aggregating content like FriendFeed or Facebook.  I have no doubt that Flickr's servers can handle another few hundred thousand image requests.  This is likely to break down when everyone's iPhone Flickr clients are also polling for this data.

The faster the polling interval becomes, the less information this image can represent.  For example, if Flickr was to generate a new image every minute, clients must poll every minute or risk missing some state changes.  This is because the image only represents state for the latest interval.

Fortunately, this issue is solved with more bits per pixel in the image representation.  You can define the hotness of a pixel as the age since the last update.  A pure white pixel represents a user who has changed state in the last interval, and shades of gray mean state hasn't changed for a while.  This allows clients to recognize state changes without being locked to the polling interval.

At the end of all this efficient polling, you still have to request the resources you are interested in.

### XMPP

In contrast, if Flickr used [XMPP Pubsub](http://www.xmpp.org/extensions/xep-0060.html) to publish feed changes, not only would clients receive real time notifications, but they would also receive the items as well.

Each time a user's state changed, an event notification would go out to all interested parties.  Most people would have subscriptions to their friend's state, and feed aggregators would probably subscribe to large portions of the data stream.

This is much more efficient as data is sent exactly when it updates and no further requests are needed to obtain it.  Data transfer efficiency is achieved in a few ways.  

First, connections can be aggregated via s2s.  Flickr does not need an XMPP connection per interested party, it just needs one per domain.  A [scalable s2s bot](http://metajack.im/2008/08/04/thoughts-on-scalable-xmpp-bots/) can be used handle notifications, making this solution quite nice.

Next, XMPP Pubsub notifications could be improved to reduce duplicate data.  Instead of sending one event to each interested party at Gmail, it could send one event that has multiple addresses.  Gmail can deliver these to the individual subscribers.  This is a lot like IP multicast.

[BOSH](http://www.xmpp.org/extensions/xep-0124.html) provides HTTP access to the XMPP Pubsub feed using AJAX long polling techniques.  This has much less overhead than the straight HTTP polling solution since it is possible to get updates in near real time and still have the idle poll time be relatively long.

## Real Time Is Better

People want their information right now, not in periodic batches.  In situations like microblogging, batching event notifications leads to awkward conversations, since the timing element is removed.  Have you ever been on an international telephone call with significant delay?  It's very odd.

Humans are adapted to real time feedback.  If you listen to your own voice delayed slightly it will completely obliterate your ability to speak.  Our brains are built to make decisions on the move while respond to enormous amounts of stimuli.  Latency in signals or their processing resulted in death.

Some data is not relevant for very long.  Not that many people are currently concerned with the path changes of hurricane Gustav, but this was extremely relevant to many during the storm.  Would you rather have your storm updates in 5 minute batches, or would you prefer to get more accurate and timely information?  Power traders subscribe to real time stock feeds because 10 minutes of delay reduces their ability to respond to market conditions.

It's hard to know when real time data is important until you've had it for a while.  Like many areas of technology, many things don't seem that interesting until people have had a chance to play with them.  Many people were surprised that computers became household items or that more than 640k of RAM was important.  Even today, many are surprised how useful and powerful sharing videos has become.

We should strive to publish data in real time and watch what interesting things happen.  This means adopting new protocols like XMPP which solve problems that HTTP is not built for.
