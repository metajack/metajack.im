---
layout: post
title: Don't Be Afraid Of Change
tags: [chesspark, startups]
time: "09:14"
extended: ":EXTENDED:"
---

Many startups these days use the crutch of advertising instead of a real business model.  The reason is pretty simple:  throwing Google AdSense up on a Web site is easy and fast, and persuading users to pay for stuff is hard.  [Chesspark](http://www.chesspark.com) is a subscription based service, and in our quest for real revenue we've had to make many changes to our business model.  Some of our experiments have failed, but we continue to try new things.  We can't be afraid of change.

:EXTENDED:

## The Original Idea

Our original model was straight up subscriptions.  If you wanted to play chess on the best site around, it cost $40 a year.  We offered a two week trial period for people to test it out.

During the beta period, we allowed people to play for free, continually warning people that Chesspark was not a free service and was still in heavy development.  Some people were excited enough by what we had done to sign up early.  When we finally launched the site officially and made payment required, we had a lot of people convert to paying users.  Things were looking great.

It didn't take long for people to abuse our generosity with the trial accounts.  We originally thought that forcing users to lose their history would discourage them for creating multiple accounts, but this proved not to be a big motivator.  People played for two weeks, then created another account under a new name.

Many times these people did so in an obvious way, and this angered our paying users.  We spent an enormous amount of time tracking down these duplicate accounts and banning them.  We wrote automated tools to track people by cookies, by IP address, by password similarity, and more.  Even with this kind of heavy automation and detection, we were still spending a good part of every day just enforcing the rules.

Not only were we wasting the time spent booting freeloaders that we could've used for developing new features, but subscriptions weren't increasing much.

## Freemium

We decided to switch to the [freemium](http://en.wikipedia.org/wiki/Freemium_business_model) model.  Basic features would be free for everyone, but some features would be locked behind a pay wall.  We decided that tournaments, chess variants, social groups, daily rankings, and a few more features would require a subscription.  We also put a few ads for upgrading in the free version, including an interstitial when games were finished.

This solved much of the duplicate account problem, freeing us to work on new features and bug fixes instead of just trying to police the border.

After a month of freemium, we still weren't seeing the increase in subscriptions that we wanted.  We measured and logged any data we could to figure out why people weren't paying.  We made the signup and payment process simpler;  we fixed rare bugs in the sales flow.  Nothing made a dent.

## It's About Value

Finally we came to a conclusion.  The jump from free to subscription was not offering enough value to be compelling to our users.  We needed to change something.

The first place we changed was community.  We decided to improve some basic community features of the site that were being underused by users.  Probing a few users and finding fresh eyes to give us feedback, we discovered some very easy fixes that might help.

The first thing we did was slightly reorganize our [forums](http://www.chesspark.com/forum/).  We made the topics clearer, added a game analysis forum, and made the forums easier to get to from the well used portions of the site.

We also made it easier to get to other areas of our site such as user profiles.  We changed the AJAX client to open new Web pages for profile loads of users, instead of presenting similar information in a JavaScript dialog.  This made the transition from game client to Web site easier.

These community changes had a noticeable effect.  It took a few days, but the game analysis forum took on a life of its own.  People started to use the user profiles more.  The best part was that organic signups started to increase noticeably.

The next big change was to move a few more features behind the subscription barrier.  Bullet and blitz games are the most popular on the server, and our relentless pursuit of low latency has made them extremely fun for our users.  We made the decision to make fast games available only to paying members, except in the case where a paying member specifically invited a free one to such a game.

Now the value equation is drastically different.  Everyone benefits from a better community, and our community pay features become more compelling.   Fast games, the most popular activity, will hopefully provide a compelling reason to upgrade.

## Watch and React

It's to early to tell what the result will be of the latest changes, but we constantly monitor user feedback, site statistics, and quality of service metrics to see shifts in trends.  We'll be working on new features while we digest the latest changes.  Once trends are spotted we will make new changes and decisions, reacting to users' behavior patterns.

All of this is much harder than having Google use their finely tuned machine to serve ads to our users, but it is worthwhile.  Our paying users are fiercely loyal and create the special community that exists on Chesspark, something we would not get from a totally ad supported site.

It may be that we monetize the free users with advertising in the future.  After all, we're not afraid to change.
