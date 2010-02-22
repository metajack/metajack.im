---
layout: post
title: "Bite-sized XMPP News #4"
tags: [jabber, xmpp, twitter, identica]
time: "00:30"
extended: ":EXTENDED:"
---

Here's a collection of interesting XMPP-related updates from the
microblogging world this week:

> [malditogeek](http://twitter.com/malditogeek):
  [http://github.com/malditogeek/Pocho](http://github.com/malditogeek/Pocho)
  takes the stage! #weekendhack #xmpp #redis #ruby
  [#](http://twitter.com/malditogeek/status/9455499870)

Pocho looks to be a neat little XMPP bot that stores hashtagged
messages to XMPP group chat rooms. It also exposes these stored
messages via a web interface as well. It sounds like an interesting
bot!

> [kocio](http://identi.ca/kocio): #Jingle Nodes on Talkr.IM - simpler
  #XMPP #VoIP for the people
  [http://www.process-one.net/en/blogs/article/jingle_nodes_on_talkr.im/](http://www.process-one.net/en/blogs/article/jingle_nodes_on_talkr.im/)
  #osnews [#](http://identi.ca/notice/22507165)

Thiago talked about Jingle Nodes at the XMPP summit, and they look
interesting. I unfortunately missed his talk at the summit, but from
what I understand, it brings Skype like peer-to-peer relaying to XMPP
Jingle.

It will be interesting to see this develop further. Jingle is really
starting to become part of the normal XMPP landscape. For example, at
the summit, the N900s that Nokia kindly let us borrow all had support
for Jingle calls.

> [tofu](http://identi.ca/tofu): 'BOSH warming' ejabberd module. cool
  stuff! !xmpp
  [http://github.com/theoooo/mod_warm_bindings](http://github.com/theoooo/mod_warm_bindings)
  [#](http://identi.ca/notice/22312632)

This is another implementation of the [HTTP pre-binding
technique](http://metajack.im/2009/12/14/fastest-xmpp-sessions-with-http-prebinding/). See
[mod_prebind](http://github.com/skeltoac/http_prebind) and
[Mod_Http_Pre_Bind](http://github.com/thepug/Mod-Http-Pre-Bind) for
two other example implementations.

There is not yet a standard for this technique, so each of these
implementations does it differently. I think it's time to write a XEP.

> [stpeter](http://identi.ca/stpeter): it's somewhat amusing that both
  the SIP-Communicator client and onsip PBX support XMPP these
  days... [#](http://identi.ca/notice/22251583)

Amusing, but not surprising. After all, Cisco is a huge VoIP company,
and they themselves purchased Jabber.com. The writing has been on the
wall for a while for SIMPLE.

> [arc](http://identi.ca/arc): #jabiru is a horribly broken !xmpp
  client for !android, is this really our only option?
  [#](http://identi.ca/notice/22199211)

> [stevegibson](http://identi.ca/stevegibson): @arc: a quick google
  found the JabbIM !xmpp client for
  !android. [#](http://identi.ca/notice/22209947)

> [thaluser](http://identi.ca/thaluser): I found a GPLv2 !xmpp client
  for !android that works with #facebook called Yaxim.  Unfortunately,
  it's not in the official
  market. [#](http://identi.ca/notice/22028511)

If you're looking for an XMPP client for your favorite Android device,
these three might be worth checking out.

> [danbri](http://identi.ca/danbri): experimenting with QR Codes as TV
  Test Cards as !XMPP service discovery hack -
  [http://www.flickr.com/photos/danbri/4359291206/](http://www.flickr.com/photos/danbri/4359291206/)
  [#](http://identi.ca/notice/22085165)

> [danbri](http://identi.ca/danbri): Scanning our TV with 3g iphone;
  it reads !xmpp jid from qrcode at 3 paces
  [http://www.flickr.com/photos/danbri/4360377558/in/photostream/](http://www.flickr.com/photos/danbri/4360377558/in/photostream/)
  [#](http://identi.ca/notice/22121217)

I met [Dan Brickley](http://danbri.org/) at the summit, and he is
doing some really interesting things with remote controlling media
experiences that incorporates XMPP. I highly recommend paying
attention to what he's doing as I suspect you will be seeing more
great stuff.

> [tdfischer](http://identi.ca/tdfischer): Dear tokbox: Thanks for
  using XMPP. You make reverse engineering easy. <3, tdfischer
  [#](http://identi.ca/notice/22042454)

Thankfully, since XMPP is an open standard, reverse engineering is
unnecessary. That's the whole point!

> [mathemonkey](http://twitter.com/mathemonkey): Wow! @elance uses
  #xmpp http-bind for "workroom" collaboration service… but it's not
  accessible using ordinary XMPP client or GTalk :-(
  [#](http://twitter.com/mathemonkey/statuses/9440102285)

I wonder if this is because they use a custom authentication mechanism
or if it's just a case of not knowing the credentials to provide. In
any case, it's great to see XMPP in more places. I'm getting a little
tired of seeing so many duplicate implementations of chat services.

> [ssethi](http://twitter.com/ssethi): XMPP and One Social Web
  [http://j.mp/cRykDk](http://j.mp/cRykDk)
  [#](http://twitter.com/ssethi/statuses/9435702907)

The One Social Web presentation at the summit was one of the most
talked about, but unfortunately I showed up only at the end. I expect
we'll see some good things from this team.

> [h4nnes](http://twitter.com/h4nnes): Any recommendations for a xmpp
  client for iphone? im+ keeps crashing here :/
  [#](http://twitter.com/h4nnes/statuses/9426167172)

I use
[OneTeam](http://www.process-one.net/en/solutions/oneteam_iphone/) for
the iPhone, which has pretty good support for group chat as well as
normal IM. The recently launched [Meebo](http://meebo.com) client also
supports XMPP, but it does not support group chat.

> [vmlemon](http://twitter.com/vmlemon): Just configured XMPP-based
  FaceBook Chat in Pidgin, and pleased to see that it works as
  advertised. Now if only it supported
  federation... [#](http://twitter.com/vmlemon/statuses/9384398876)

I think Facebook will get there. Server to server communication is one
of the trickiest parts of XMPP, and it makes since that they would
save this part for last. It took Google a while to get federation
working as well.

> [dbanes](http://twitter.com/dbanes): Anyone implementing XEP-0277:
  Microblogging over XMPP ?
  [#](http://twitter.com/dbanes/statuses/9366735983)

I just heard about such an implementation from a
[comment](http://disq.us/bttxl) on my blog. The site is called
[BuddyMob](http://www.buddymob.com/), and apparently is an extended
implemenation of
[XEP-0277](http://xmpp.org/extensions/xep-0277.html). Hopefully the
extensions will find their way into the specification as well.

> [jprieur](http://twitter.com/jprieur): Archipel, xmpp based
  orchestrator for virtualization
  [http://www.archipelproject.org/](http://www.archipelproject.org/)
  [#](http://twitter.com/jprieur/statuses/9332433124)

This looks like an interesting start to virtualization infrastructure
management.

> [drunknbass](http://twitter.com/drunknbass): I'm thinking you could
  totally power a game like words with friends with XMPP (openfire)
  [#](http://twitter.com/drunknbass/statuses/9319148406)

I think that would be a great weekend project, and XMPP would be a
perfect transport. With [Strophe.js](http://code.stanziq.com/strophe),
HTML5 Canvas, and some JavaScript, this game could be made fairly easily.

> [xmppjingle](http://twitter.com/xmppjingle): @pedrosorren Do you
  know Microsoft released an XMPP Gateway for its OCS closed services,
  due high customer demand? #theworldisopen
  [#](http://twitter.com/xmppjingle/statuses/9282261422)

One day, maybe we'll see MSN and AIM get XMPP gateways just like
Facebook. Sometimes it takes a decade or so for a project to fulfill
its original goals.

> [xmppjingle](http://twitter.com/xmppjingle): Facebook announced that
  their are building Mobile APIs, why not just expose its services
  over XMPP? The Chat works extremely well so far
  [#](http://twitter.com/xmppjingle/statuses/9282119001)

I think it makes a lot of sense to have a native XMPP interface to
these APIs. For example, Gmail has shown that even though its mail
interface doesn't map cleanly to IMAP, there is enormous value in
leveraging IMAP clients. Sure, it takes a little thought and planning,
but the end result is well worth it.

> [rektide](http://twitter.com/rektide): what do #buzz, #xmpp, and to
  a degree #wave have in common? failure to abide the most
  basic/essential axiomatics of the #web; the
  uri. [#](http://twitter.com/rektide/statuses/9244312851)

URIs are great and are used in XMPP where they make sense. I think
most people would agree that e-mail style addresses are easier to use
for humans than most URIs, though. XMPP is not a solution to all
problems, and neither is HTTP.

That said, I've seen several efforts now to bridge some of the gap
between HTTP and XMPP - sending stanzas through REST APIs, exposing
chat rooms as web pages, etc.

> [gashcrumb](http://twitter.com/gashcrumb): just a little bit closer
  to having a proper mock XMPP server to run unit tests against.
  nice! [#](http://twitter.com/gashcrumb/statuses/9198982133)

I hope this will be open sourced. There is unfortunately little in the
way of specific XMPP testing tools. This is often brought up at the
XMPP summits as something most of us want and need, but so far it has
proved more complicated that it looked.

