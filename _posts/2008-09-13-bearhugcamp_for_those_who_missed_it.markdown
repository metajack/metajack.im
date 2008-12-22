---
layout: post
title: BearHugCamp For Those Who Missed It
tags: [bearhugcamp, identica, jabber, laconica, microblogging, xmpp]
time: "02:15"
extended: ":EXTENDED:"
---

[BearHugCamp](http://www.microblog.org/wiki/BearHugCamp) is over, but the real fruits of the meeting will come over the next several weeks in the form of new code, new projects, and new discussions.  Unfortunately, not everyone could be there, but many followed along on the [live stream](http://twitlive.tv).  Hopefully the recording and its chat logs are archived and will be available soon.  For those of you who prefer to read rather than watch, I present my lightly annotated notes from the conference.

:EXTENDED:

## The Hallway Track

I arrived slightly late, and casual conversations were well underway.  CNet not only provided an excellent space for this event, but coffee and bagels were ready and waiting for all.

I made it no further than ten feet inside when I ran into [Fritzy](http://identi.ca/fritzy), [Bear](http://identi.ca/bear), and [Brian Hendrickson](http://megapump.com).  We had a short little conversation about [Strophe](http://code.stanziq.com/strophe) and [BOSH](http://www.xmpp.org/extensions/xep-0124.html).  I believe BOSH will be very important in bringing the XMPP APIs of microblogging to the Web in a seamless way.  [Yammer](http://www.yammer.com) is [already doing this](http://metajack.im/2008/09/09/yammer-launches-strophe-powered-microblogging-for-businesses/).

Brian mentioned he had created a second PHP implementation of [OpenMicroblogging (OMB)](http://openmicroblogging.org).  One notable feature is that his implementation supports [Wordpress](http://www.wordpress.org) themes.  For any open standard to succeed, it needs multiple implementations keeping the specifications honest and relevant.  It's great that a second implementation already exists, and I hope more will surface over the coming weeks and months.

The [Seesmic](http://www.seesmic.com) guys (Fritzy, Bear, and [Loic](http://loiclemeur.com/)) mentioned that they were very happy with the [Tigase](http://tigase.org) XMPP server, and were sponsoring its development.  Fritzy has been developing unit tests for [XMPP Pubsub](http://www.xmpp.org/extensions/xep-0060.html), and these have already led to improvements in at least two implementations.  It's great to see companies giving back to the community like this; everybody wins.

[Evan](http://identi.ca/evan) soon appeared, and we talked about the merging plan to build another OMB implementation built on [XMPP](http://www.xmpp.org).  The goal is to build OMB with a native XMPP API and then combine it with Evan's work with the REST API.  I'll talk more about this in the future; this is a hot topic in the XMPP community right now.

[Kevin Marks](http://kevinmarks.com) from Google joined us to tell us about the new [Portable Contacts specification](http://portablecontacts.net/draft-spec.html).  It sounds very interesting.

Pretty soon [Leo Laporte](http://twit.tv) had the audio/video set up ready, and [Steve Gillmor](http://identi.ca/stevegillmor) took a seat in front to start us off.

## Who's Who Of Microblogging

There were quite a few people at BearHugCamp as well as some notable omissions.  Most of the major people who participated will appear in the notes, but I'll mention some companies briefly.

Google, Microsoft, and Facebook all had representatives.  The Twitter guys showed up briefly before lunch, but missed the rest of the conference.  Three people from Seesmic came.  Someone from Friendfeed wanted to come, but they were busy releasing some new features and couldn't make it.  Gnip, a consumer of the Twitter firehose, was also missing.

## Real Time And Track

Steve made it very clear from the beginning that he wants Twitter's defunct track support back. He described track as "real time search in the now".  He lamented that the current workaround of [Twitter search](http://search.twitter.com) is subpar; it is often an hour to three days delayed.  Track is more like a filter.

Leo jumped in saying that we an open network not a bunch of silos; content should be available to everyone.  I couldn't agree more.  This view was shared by nearly everyone in the room.

Steve was asked to define track for those that didn't know about it.  He described it as a real time conversation between nodes that don't necessarily know each other.  Twitter turned this functionality off around May 23rd, and it has not been turned back on.  It was mentioned (I don't remember who) that waiting for Twitter to bring back track was hopeless and not worth waiting for.

Evan then started to talk about OMB.  He mentioned there are 150 to 200 microblogging services today.  With so many services, it's clear that track-like functionality is going to have to come from a centralized aggregator to cover everything, but that individual services can have local track built in.

I announced my plans to provide exactly such an aggregation service for the OMB community using XMPP Pubsub.  We'll consume public feeds from Identi.ca and others, and make these available en masse to others.  We'll also be building track functionality as well as other interesting services on top of this firehose.  

Someone mentioned that track was a form of discovery, and this immediately brought about talks of spam.  Steve said that it wasn't such a big deal for end users, and that track filtering solved many of its problems.  Fritzy brought up that filtering can be improved through metadata like the data source.  This metadata is sent out of band, meaning not in the SMS-limited 140-160 characters of standard data.

Steve brought up that metadata formats are a political issue and that people like [Jon Bosak](http://research.sun.com/minds/2004-0701) in the XML community have spent 15 years trying standardize business schemas.  I agree that politics are involved, but we are already involved in them, and there are ways to deal with them.  OMB is already a standard with politics involved.  Setting up a standards ombudsman is the normal solution, and has worked for years for Internet standards.  The [XMPP Standards Foundation (XSF)](http://www.xmpp.org) is a great example o this.  Others are the [IETF](http://www.ietf.org) and [W3C](http://www.w3.org).

Steve explained that the principle of bear hugging is to find the market forces at play, figure out which one is least onerous, and bear hug them.

[Dave Winer](http://www.scripting.com/) mentioned that Twitter could be come the centralized directory.  He has moved back to Twitter even though he hates it because of the large community he can reach there.  He rightly urged the rest of us not to build systems around a single vendor.

Evan presented an example he called "flipping the iceberg" of what happened with e-mail.  The big, early players in e-mail, like AOL and CompuServe, dictated the standards.  There was no value for them to link together or with others.  They leveraged the network effect to exert market pressure.  The dynamic started to change as more and more little players pooled together eventually surpassing the walled gardens in size.  He claims that this is what will have to happen with Twitter.  Currently there are around 2.2 million Twitter users, and Evan's generous estimate for other microblogging users was around half a million.

Dave Winer brought up the argument against extending microblogging past 140 characters.  Evan originally opposed the length limit, but has since changed his mind.  I'm still not convinced we should let SMS's arbitrary restrictions limit the entire space, but that is an argument for another time.  Dave mentioned that OMB needs plugins and payloads.  Thankfully, plugins and payloads come basically for free with XMPP.

Loic announced that the new version of [Twhirl](http://www.twhirl.org/) (released hours before) supports arbitrary Laconica instances like [TWiT Army Canteen](http://army.twit.tv).  Bear added that payloads are easy with XMPP and that Twhirl, like any normal XMPP node, passes them around intact.  Dave Winer explained this in terms of RSS enclosures - it's like attaching a file to your message.

Steve asked Evan and Loic if they would be willing to add support for payloads, and both of them affirmed they would.

## Grilling Twitter

The Twitter crew arrived: [Jack Dorsey](http://twitter.com/jack), [Biz Stone](http://twitter.com/biz), and [Alex Payne](http://twitter.com/al3x).

Steve immediately asked when track would be back, and the rest of the room laughed.  Jack Dorsey, CEO of Twitter, explained that they had some scalability and uptime issues.  Twitter is not comfortable putting out features that won't scale.  I imagine what he meant were features that the Twitter team hasn't figured out how to scale yet.  He then said they are focusing on their foundation, and that the acquisition of Summize will help them bring back track.  They are just waiting for confidence in their ability to scale.

Steve asked about the restoration of the XMPP interface.  Jack replied that they are first going to integrate search into the Web site before they get to XMPP.  Steve pushed harder, and Jack finally said that track would come back before the XMPP interface was restored.  It depends on their resources.

Twitter is currently 24 people, and they are all fully tasked on other projects and don't yet have room for the IM interface.

Twitter was pressed about how to get a firehose feed.  Gnip already has a feed; should the community turn to them for the Twitter firehose?  The Twitter team explained that while they provide Gnip a full feed, Gnip does not currently reflect all the data.  Dave Winer mentioned that the Gnip team told him that they would love to reflect the Twitter feed but that the terms of their relationship with Twitter do not allow such uses.  There was not a straight answer from the Twitter guys about whether this was true or not.

Steve reiterated that "track is a supremely useful service".  [Ken Sheppardson](http://identi.ca/kshep), Steve, and others continued to press Twitter about how others can acquire the firehose so that third party implementations of track would be possible.

Team Twitter said they were at a stage where they are actively seeking out input as to what is important to developers.  They were asked again how developers can get a feed. Alex finally revealed that the starting point is to contact him [via email](mailto:alex@twitter.com).  Information on the various feeds is available on Twitter's [API wiki](http://apiwiki.twitter.com).  Information on the various feeds is not new and has been in the open.

Twitter has various feeds aside from the firehose.  There are RSS feeds for search in addition to the main API.  These are restricted by polling limits, but these can be removed by asking to be whitelisted.  There is also a "research" feed available that gives a sample 600 messages every 60 seconds.  None of these feeds are really appropriate for people trying to implement services like track, and real time is not possible since the feeds have delays.

The question was asked if getting a feed was hard for technical or business reasons.  They answered that their lawyers are still working on the terms of service for firehose feeds.  I remarked that much of the firehose is available in their other feeds which do not have this TOS and asked why the firehose was different.  Unfortunately instead of the desired result of convincing them to open up the firehose, I think we will see this TOS, which is probably fairly restrictive, applied to the other feeds.

The final answer was that getting a firehose feed is a Twitter business decision.  They were unwilling to talk about specific terms.  We'll have to discuss it with them individually or wait and see what their terms of service look like.  They have clearly chosen to be wary of opening up this information, and I suspect this will continue to be one of the primary motivators of OMB.

Alex had a lunch presentation at Twitter so the Twitter team left.  Steve called for a much needed break.

## Facebook, Google, and Microsoft

Steve introduced [Ari Steinberg](http://blog.new.facebook.com/blog.php?blog_id=company&blogger=211031) from Facebook.  We got into a discussion about the social ramifications of the word "friend" and the cultural ramifications of friending versus following.  Kevin Marks remarked that Facebook and Twitter are starting from different points culturally.

Ari mentioned that the [promised XMPP support](http://www.facebook.com/news.php?blog=1&story=110) for Facebook chat was a project that one developer was doing in his spare time.  Steve rightly chimed in "We keep hearing this over and over.  It's just one guy doing it."  Clearly the big players feel little motivation to federate.

Angus was asked to describe the suitability of [Windows Live Mesh](https://www.mesh.com/Welcome/Welcome.aspx) for microblogging.  He explained that they have a store and forward system optimized for sync, not pubsub type things like microblogging.  He mentioned that there are 300 million Messenger users and 350 million Hotmail users which have their contacts in the "address book clearinghouse".

Kevin Marks talked about how there are two sides to microbloggin, the blog style or archive side and the flow side.  I think both sides are interesting, but people are much more excited about the flow possibilities.  The real time nature of the conversation is new and exciting.  It was noted by someone that it is hard to find archives of old Twitter stuff now, and that they have moved from the archive side more towards the flow side.

Everyone was getting hungry so we broke for lunch.  I had plans to dine with my brother-in-law and his girlfriend, so I did not join the others, and therefor, I have no notes to share about the conversations that happened at lunch.

## Steve Abdicates The Throne And We Learn About Laconica

While we were all back in the hallway track of the conference, Steve checked the feedback in the chat room, on Twitter, and on Identica.  After remarking about a few snarky comments, he got visibly upset, shut his laptop and started to leave.  We tried to coax him back, but Leo ended up taking over the moderator role for the rest of the time.

Leo invited Evan up to talk more about Laconica.  Evan described Laconica at a technical level starting with all the ways data flows into and out of the system.  

When talking about SMS, he mentioned that they use email as a work around since getting an SMS short code is prohibitively expensive.  He said it cost about $0.15 or $0.20 per message sent and wondered how Twitter could afford to pay it.  Angus mentioned that [Live Alerts](http://dev.live.com/alerts) provided some SMS functionality for free, and that Laconica users could potentially just use that.

Laconica has cloned the Twitter API except for direct messaging and favorites.

On the topic of public feeds, HTTP push was discussed.  This is currently being used for the TWiT Army Canteen and works well.  Evan would like to get this into Laconica.

[Dustin Sallings](http://identi.ca/dustin) suggested that we outsource the XMPP streams for the smaller OMB nodes to upstream aggregators.  With HTTP push as a feed option for smaller sites, it is possible to deploy on Google App Engine where daemons are not allowed.  This is a great idea, and I talked with Evan later about putting this into the OMB specification.  Kevin Marks also mentioned that SixApart has implemented some kind of custom streaming HTTP feed that the Laconica team should look at.

Evan continued with his list of things he wants to see in the future: an updated [microblogging XEP for XMPP](http://www.xmpp.org/extensions/inbox/microblogging.html), an OAuth HTTP API to improve upon the Twitter API, AtomPub support, and OMB without subscription (federated @-replies).

He also talked about integration with the [OpenSocial](http://code.google.com/apis/opensocial/), the [Social Graph API](http://code.google.com/apis/socialgraph/), and Facebook and Google contacts.  He wants to copy what [Dopplr](http://www.dopplr.com) does for discovery.  Kevin Marks suggested looking at the [Portable Contacts specification](http://portablecontacts.net/draft-spec.html) again, both exporting and importing.  He claimed it was perfect for discovery.

Evan explained the difference between Identica and Laconica.  Identica is a public microblogging service.  Laconica is the software that runs Identica.  He stated that he is thinking of merging the names, akin to [wordpress.org](http://www.wordpress.org) and [wordpress.com](http://www.wordpress.com).

He also stated his reasons for open sourcing Laconica weren't entirely altruistic.  The network effect of communications networks is too important, and it helps to have others do some of the work.

There was some discussion of what kind of hardware Laconica requires.  Identica is running on Amazon's [Elastic Compute Cloud](http://aws.amazon.com/ec2).  Leo shared that the TWiT Amry Canteen runs on a small virtual server and consumes basically no resources for the 3,000+ users it has.  I chimed in with [Jabber.org's](http://www.jabber.org) numbers for its XMPP service for comparison.  It supports 10-15,000 simultaneous connections from 400,000+ users, and it consumes about 10% of the CPU of a physical machine with a couple of cores.

Finally, Evan shared that Laconica 0.6, which is due out very soon, will have a Twitter bridge.

## The Seesmic Team

Loic had to leave, so he was asked to share what Seesmic was doing on his way out.  He claimed Seesmic had half a million videos posted so far and the current rate of new content was about one video per minute.  They acquired the Twhirl client which has become the most popular client for Twitter, FriendFeed, and Identica.  It's so popular on Twitter that it has more users than the next three clients combined.

Fritzy and Bear joined him and announced that the Seesmic firehose would be available to everyone.  More information is forthcoming at the [Seesmic wiki](http://wiki.seesmic.com).  This is great news and demonstrates their commitment to this community.

## Winding Down

Evan then brought up aggregation models and how they could be layered.  It was eventually decided that these topologies should be allowed to grow organically.  Ken, Dustin, and myself are all working on aggregation, and I imagine others will be as well.

Steve stressed the importance of federated @-replies.  Evan mentioned that this is the main vector for spam in the system.  The consensus was that we shouldn't care about this right now.  Users will sort it out themselves if we give them appropriate tools.

The main hold up for these federated @-replies is how to handle addressing.  There was a rough consensus that bare JIDs be used.  These would be augmented with various guesswork and mnemonics to make life easier for users.  For example, `@evan` would first search recent messages and then people you are following in order to disambiguate to `@evan@identi.ca`.  A registry of short codes was proposed so that users could write addresses like `@evan/id` which would resolve to `@evan@identi.ca`.  The resolution would be via DNS queries to some canonical server.  This is similar to how the XSF has a registrar to keep track of URIs for the various protocols and extensions.

We also discussed that SRV should be used to have multiple Laconica instances under the same domain.  This requires people run multiple instances using subdomains instead of using specific URLs which everyone seemed to like.  This mirrors how SRV records are used for XMPP servers, which is necessary since we want OMB to integrate well into XMPP land.

One of the [TC50](http://www.techcrunch50.com/2008/conference/) Demo Pit companies, [Peoplebrowsr](http://www.peoplebrowsr.com) gave an overview of what they were doing.  They have a lot of bridges set up through a rich JavaScript client.  A public demo is coming soon.

Kevin Marks then reminded us one last time that we should definitely check out the work Google is doing with the OpenSocial related APIs, which we definitely should.  

With that the official conference ended.  I had to catch a plane home, so I said my goodbyes and had a few short conversations as I left the room.  I believe the plan was for everyone to head to the [House of Shields](http://houseofshields.com/) for drinks and merriment.  Hopefully someone remembers the interesting conversations that happened and will share them.

## It's A Great Time For Microblogging

I met some great people today, and I'm extremely excited about OMB and the possibilities of federated microblogging and services built on top of real time feeds.  If attendance is any indication, so are many others.

I wanted to get my notes and recollections written down while they were fresh.  I will definitely be talking more about these ideas soon, once the ideas have had a little time to simmer.

I apologize if I left anyone or anything out, or if something was inaccurate.  Please let me know if this has happened, and I will fix it.

**UPDATE**: Corrected Twitter team names and fixed and linked Jon Bosak.
