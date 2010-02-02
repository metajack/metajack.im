---
layout: post
title: Bite-sized XMPP News #3
tags: [jabber, xmpp, twitter, identica]
time: "22:05"
extended: ":EXTENDED:"
---

Here's a collection of interesting XMPP-related updates from the
microblogging world this week:

> [http://identi.ca/gavincarr]: Nice - after some naffing around got
> @precision's twitter-xmpp working
> [http://github.com/precision/twitter-xmpp/](http://github.com/precision/twitter-xmpp/)
> !xmpp [*](http://identi.ca/notice/20410490)

Precision is a simple XMPP to Twitter gateway, and it even supports
[OAuth](http://oauth.net). It appears that this brings back the old
XMPP functionality of Twitter, although it's probably not as fast as
the real thing used to be. You can also use
[tweet.im](https://www.tweet.im/) if you'd rather not run your own.

> [stpeter](http://identi.ca/notice/20405955): Mozilla Weave has hit
> 1.0, another cool project using XMPP!
> [*](http://identi.ca/notice/20405955)

> [nyconyco](http://twitter.com/nyconyco): @stpeter I don't think
> Mozilla Weave 1.0 has XMPP (found no traces), but I've heard it was
> planned... [*](http://twitter.com/nyconyco/status/8381373313)

As far as I can tell, [Weave](https://mozillalabs.com/weave/)
currently uses [WebDAV](http://www.webdav.org/) currently. Apparently,
they are [looking to replace that with
XMPP](http://mail.jabber.org/pipermail/social/2008-July/000308.html)
eventually.

Meanwhile, Google's Chrome browser sync [will use
XMPP](http://googlesystem.blogspot.com/2009/08/google-chromes-browser-sync.html). This
makes a lot of sense as Google already has a big technical investment
in XMPP with Google Talk.

> [fritzy](http://identi.ca/fritzy): Friend, "How do you pronounce
> !XMPP anyway? "Zump!"" Everyone just says the letters, but I'll
> start saying Zump! now. [*](http://identi.ca/notice/20131082)

> [stpeter](http://identi.ca/stpeter): @frtizy at FOSDEM last year
> someone came up to the XMPP table and asked "what is Zimpy?" :)
> [*](http://identi.ca/notice/20138551)

This made me laugh, but I have to say, I really like "Zump!" too.

> [laibcoms](http://identi.ca/laibcoms): Is it just me or #Google Talk
> doesn't recognize !XMPP Priority setting? When I send a msg, all
> logged-on accts receives it #Jabber
> [*](http://identi.ca/notice/19990078)

I believe that Google Talk (as well as some other servers lke
[ejabberd](http://www.ejabberd.im)) deliver stanzas to the resource
with the highest priority, and in the case of a tie, they will deliver
the stanza to all tied resources. The current [XMPP
specifications](http://xmpp.org/rfcs/) allow the server discretion in
how to handled tied priorities. This is one of the things being talked
about a bit for the [upcoming
revisions](http://metajack.im/2010/01/28/xmpp-core-specifications-being-updated/).

I believe most of the XMPP community considers multiple resource
delivery in the case of a presence priority tie to be the correct
solution. There is some support for making this less ambiguous in the
new drafts. Note that this would still be a "SHOULD" and not a
"MUST". It's best to leave servers flexibility in case new use cases
come up.

> [deetman](http://identi.ca/deetman): Is it time to go home yet? Much
> xmpp coding to be done! [*](http://identi.ca/notice/20020395)

I'd love to hear what you're making. Sounds like you are enjoying your
work!

> [tbielawa](http://twitter.com/tbielawa): Back on the @erlang train
> after a little break. Going to master the gen_server module and
> begin groundwork for PAD-XMPP!
> [*](http://twitter.com/tbielawa/status/8473175219)

[PAD-XMPP](http://github.com/tbielawa/PAD-XMPP) looks like a new XMPP
server and client in Erlang, done as a learning project. I'll have to
keep an eye on this!

> [acscherp](http://twitter.com/acscherp): #zotonic #pubsub is coming
> along nicely... publisher side is already in
> place. [*](http://twitter.com/acscherp/status/8468540623)

[Zotonic](http://zotonic.com) is an up-and-coming CMS written in
Erlang. I've been hearing a lot about Zotonic lately, and I hope to
have some time to check it out soon.

It's won't be the only CMS with XMPP support; Drupal has [XMPP
support](http://drupal.org/project/xmpp) as well.

> [garethr](http://twitter.com/garethr): looking at the devrooms for
> FOSDEM:
> [http://www.fosdem.org/2010/schedule/devrooms](http://www.fosdem.org/2010/schedule/devrooms). Thinking
> NOSQL and XMPP will keep me occupied
> [*](http://twitter.com/garethr/status/8451856550)

I'll probably be right there with you as I'm a huge fan of both. Don't
forget about the [XMPP Summit](http://xmpp.org/summit/summit8.shtml),
which is held on the days before and after
[FOSDEM](http://www.fosdem.org).

> [jprieur](http://twitter.com/jprieur): Reading about the OSLO
> protocol, data exchange over #xmpp location-based social networks
> [http://code.google.com/p/oslo-protocol/](http://code.google.com/p/oslo-protocol/)
> [*](http://twitter.com/jprieur/status/8427383999)

Johann continues to find new and interesting XMPP projects. I don't
think you'd regret following him if you have an interest in XMPP.

> [asabil](http://twitter.com/asabil): Is the ps3 using #XMPP for IM ?
> [*](http://twitter.com/asabil/status/8418520998)

I hadn't heard this, but it is certainly possible. Does anybody know?
For that matter, does XBox 360 use MSN or something custom?

> [peterneubauer](http://twitter.com/peterneubauer): Project #gargamel
> is starting. Distributed #graph processing on #xmpp, #gremlin and
> \#linkedprocess. On #rdf, #neo4j, #sail,
> \#linkeddata. [*](http://twitter.com/peterneubauer/status/8405566771)

[Linked Process](http://www.linkedprocess.org/Home.html) is an
interesting project allowing people to do Internet-scale computing in
a decentralized way. They use XMPP to enable this, and the programs
can be written in many languages. They've even [started a
XEP](http://xmpp.org/extensions/inbox/lop.html) that describes the
protocol.

> [chrisridd](http://twitter.com/chrisridd): Adium's pretty rubbish
> for MUC chats. Is there a better XMPP client for Macs?
> [*](http://twitter.com/chrisridd/status/8383283844)

> [chaz6](http://identi.ca/chaz6): Giving a new #xmpp client called
> Vacuum IM a spin. So far so good! #qt
> [*](http://identi.ca/notice/20354385)

The elusive perfect XMPP client quest will probably never end. It is
good to see newcomers into this space; there is certainly a lot of
room for improvement even in the very best clients. It looks like
[Vacuum IM](http://code.google.com/p/vacuum-im/) is a project from a
group of Russian developers. Let me know what you think of it if you
give it a whirl.

> [adilsonchacon](http://twitter.com/adilsonchacon): Studing how Ruby
> Language works with XMPP. Having a lot of challenges... and fun!
> [http://home.gna.org/xmpp4r/](http://home.gna.org/xmpp4r/)
> [*](http://twitter.com/adilsonchacon/status/8375958584)

There are a lot of Ruby hackers using XMPP these days, and plenty of
great Ruby-based XMPP projects. I suggest keeping an eye on what
[Pradeep](http://twitter.com/pradeep24) (and his [GitHub
forks](http://github.com/skyfallsin/)) and
[Seth](http://twitter.com/mojodna) (and his [Github
forks](http://github.com/mojodna)) are up to.

> [OhCrap](http://twitter.com/OhCrap): only thing that puzzles me is
> that gtalk is showing me offline. Is presence a one way thing for
> XMPP? Maybe just takes time for Google?
> [*](http://twitter.com/OhCrap/status/8327951916)

In XMPP, presence subscriptions are directed. Each side must allow the
other to subscribe in order to have the traditional friend or buddy
relationship in other systems. This is exactly the way Twitter
following works. 

In the common cases, this two directional nature is often hidden, but
it is great when you need to allow bots and services to see your
presence without cluttering up your own roster with a reciprocal
subscription.

> [bokner](http://twitter.com/bokner): Erlang behaviour for XMPP
> client:
> [http://rfid-ale.blogspot.com/2010/01/genclient-behaviour-for-building-xmpp.html](http://rfid-ale.blogspot.com/2010/01/genclient-behaviour-for-building-xmpp.html)
> [*](http://twitter.com/bokner/status/8314296646)

This looks like a cool projects. It extends Erlang OTP-style behaviors
to something that enables easy writing of XMPP clients. It's based on
[exmpp](https://support.process-one.net/doc/display/EXMPP/exmpp+home)
and inspired by [Strophe](http://code.stanziq.com/strophe). I'll
definitely have to check this out as I've been thinking about working
on a similar project. The code is [available on
GitHub](http://github.com/bokner/gen_client).

> [zuwiki](http://twitter.com/zuwiki): SleekXMPP is awesome. I just
> hacked together a (barely functional :P) XMPP client in under 45
> lines and 40 minutes without even
> trying. [*](http://twitter.com/zuwiki/status/8224912340)

[SleekXMPP](http://nathan.fritzclan.com/2007/04/sleekxmpp.html) is a
great Python library for programming XMPP clients. I myself prefer
[Wokkel](http://wokkel.ik.nu), but most stories about Sleek are
similar to zuwiki's.

> [dwc](http://twitter.com/dwc): XMPP is such a heartless protocol in
> letting me know when people have left the
> conversation. [*](http://twitter.com/dwc/status/8221506478)

I never thought of it that way, but I suppose it's somewhat true. It's
also what gives instant messaging much of its appeal. With e-mail, I
have no idea if the recipient is around. With XMPP, I know they are
there, and while I'm chatting, if they are actually paying
attention. These can be helpful clues to ease virtual communication.
