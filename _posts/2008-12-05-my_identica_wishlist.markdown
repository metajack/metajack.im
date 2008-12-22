---
layout: post
title: My Identi.ca Wishlist
tags: [identica, jabber, microblogging, openmicroblogging, xmpp]
time: "23:28"
extended: ":EXTENDED:"
---

[Identi.ca](http://identi.ca) has come a long way in a short time.  Although I don't agree with all the technical decisions [Evan](http://identi.ca/evan) makes, by and large, he's created a useful service and a community that I enjoy participating in.  Having been a regular user or some time, I have accumulated a number of wishlist items that I would love to see implemented.



:EXTENDED:

## More XMPP Integration

While I would love for Identi.ca to use XMPP on the back end, that is not what I mean in this case.  The XMPP chat interface to Identi.ca works quite well, but it is limited to receiving and posting dents, and posting private dents.  Here are some of the missing pieces I'm waiting for:

* Direct messages should go to my IM client; currently I have to use the Web site to receive direct messages, even though I can send them right from my IM client.  It would be even better if the XMPP bot was rewritten as a component so that it could make direct messages appears in new tabs like [Tweet.im](http://tweet.im).
* Subscribing and unsubscribing from contacts is only available on the Web site.  I would love to be able to type `follow tetsuo` when I notice someone having an interesting conversation with someone I don't know.  This would go perfect with the unsubscribed @-reply support that was recently added.
* Notices of favorites should get sent to my IM client as well, perhaps as a configurable option.  I don't want to keep switching back and forth between e-mail, the Web browser, and my IM client.
* [Enjit](http://enjit.com) has a great reply system in their real time [FriendFeed](http://www.friendfeed.com) interface.  It would be nice to have something like this in Identi.ca, and one use of it would be to allow marking favorites right from the IM client.

## Stop Teasing Me

Why does Identi.ca tease me so?  Everytime someone favorites one of my dents, I get a e-mail notice about it.  That notice however doesn't include the text of the dent I sent, so I have no idea which dent amused them without clicking through to the Web site.  

I feel like Identi.ca does not respect my time when it makes me jump through this hoop.  Just give me the data I want already; it's not like Evan has ads to sell on the Web site.

## IM Interface Polish

The Web interface has lots of polish that does not exist yet in the IM interface.  For example, the Web interface will shorten URLs automatically.  It will also put the real URL in the tooltip.  The IM interface has none of this.  I have to manually shorten my URLs, and I never know what kind of link I'm clicking on.

## Out Of Band Information

I like tags, but rarely use them because they eat up a lot of my 140 character allotment.  These should be transmitted out of band in the Atom payload and not count against my character limit.  I think they would be a lot more useful this way.

The IM interface could just append them to the end of dents, just as if the person had typed them there.  It could also append any of the automatic tags that are not supported at Identi.ca.

## Changelogs and Documentation

Evan and others are adding new features all the time, but half the time I never know about them until I see someone else using them or discussing them.  Identi.ca really needs a small blog that posts all the updates and new features.  I want to play with new stuff, but I can't if I don't know about it.

It would also be great if all the features were documented somewhere.  i see peole talking about the new `@#tag` type group support, but I can't find anything about how this works.  New people coming to the service are going to have a steeper and steeper learning curve.

At least the thriving community makes it easy to pick up these things by osmosis, but it could be better.

## What About You?

What are your wishlist features?  Even if you use some other microblogging server, I'd love to know what you find lacking.  The ideas are still young, and I'm excited to see all the experimentation.

If you aren't on Identi.ca, give it a try.  You can follow me at [identi.ca/metajack](http://identi.ca/metajack).
