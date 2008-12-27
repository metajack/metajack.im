---
layout: post
title: Twitter Says They Have Data, But They Just Have A Big Mouth
tags: [gnip, jabber, microblogging, twitter, xmpp]
time: "22:31"
extended: ":EXTENDED:"
---

[Alex Payne](http://twitter.com/al3x), [Twitter's](http://twitter.com) API lead, just [teased everyone](http://dev.twitter.com/2008/10/we-got-data.html) with "We Got Data".  We all know Twitter has data, but everyone wants access to the firehose and Twitter has been very reluctant to share it.  With such a data stream we could bring back track, IM integration, and experiment with many other things as yet unimagined.  Come on, Twitter; put your data where your mouth is.



:EXTENDED:

## The Saga Of The Firehose

Back in the time before time, getting access to Twitter's firehose was just a question of asking nicely.  They were happy to share, and interesting applications were born.  Where would Summize, since acquired, have been without access to this data?

I don't know the exact time that they started pruning the list of consumers of the firehose, but to me it seemed like this starting happening after Summize was acquired or around that time.  The logical conclusion from this is that Twitter does not want more interesting things being built on top of its data.  I'm not sure anyone really noticed until they started removing all the interesting features like track and IM integration.

At and after [BearHugCamp](http://metajack.im/2008/09/13/bearhugcamp-for-those-who-missed-it/), the Twitter folks told us to talk to [Gnip](http://www.gnipcentral.com) to get access to the firehose.  Twitter's systems weren't set up to handle broadcasting the firehose, and Gnip was set up to do exactly this.  Many of us immediately started conversations with Gnip.  I can only speak for myself, but as far as I know, we are all waiting for access.

Now Alex gives us a tiny clue:

> We've looked at third-party solutions for relaying the full stream, but we think we can provide the best developer experience ourselves.

This does not bode well for those of us hoping Gnip will start relaying the firehose.  Why would Twitter allow Gnip to compete with them if they think they can do it better.

## Unanswered Questions

All we are left with is unanswered questions.

Will Twitter make the firehose available to third parties either by themselves or via some aggregator like Gnip?  None of the conversations I or others have had have ended in a "yes" so far.  Alex's post looks like it might give some hope, but this is essentially the same story we've been hearing for a while.

Will we have to pay to access this data?  Through Gnip the answer is yes.  According to their site, Gnip will charge $1,000 a month per feed source.  Will Twitter do the same?  Is this going to be their elusive business model?  How much will it be?

What are the terms and conditions of the data?  At BearHugCamp they said they were waiting on lawyers for the terms of service of the firehose.  Why does the firehose need a TOS and not any of the HTTP APIs?  The cat is already out of the bag, guy; people are already using this data all over the place.

And most importantly, when will access to the firehose be available?  Some of us, myself included, already have running code that is just waiting for this elusive data.  Applications like [Twitterspy](http://www.techlifeweb.com/2008/07/07/how-to-set-up-twitterspy-in-google-talk/) are not nearly as useful as they could be without the firehose.

Sorry, Twitter. Until we see some answers, you don't have data, just a big mouth.
