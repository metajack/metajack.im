---
layout: post
title: Bite-sized XMPP News #2
tags: [twitter, jabber, xmpp, identica]
time: "20:37"
extended: ":EXTENDED:"
---

Here's a collection of interesting XMPP-related updates from the
microblogging world this week:

> [thatfleminggent](http://twitter.com/thatfleminggent): Migrated my
  \#xmpp server to #prosody from ejabberd. Just need to get my ICQ
  transport showing up in service discovery again
  [#](http://twitter.com/thatfleminggent/status/8166262405)

> [goldstein](http://twitter.com/goldstein): Prosody is ridiculously
  fast for single server environment. Migrating over from #openfire
  [http://gist.github.com/180477](http://gist.github.com/180477) #xmpp
  #prosody [#](http://twitter.com/goldstein/status/8154338404)

[Prosody](http://prosody.im) is getting a lot of well deserved
attention these days. Matthew and team have done an amazing job, and
they don't seem to take breaks to eat or sleep. I run Prosody for the
metajack.im XMPP server, and it's been a breeze.

> [daveoflynn](http://twitter.com/daveoflynn): @ebarroca XMPP is far
  more difficult to implement than Twitter API access. Streaming XML +
  async presence notifications etc is
  non-trivial. [#](http://twitter.com/daveoflynn/status/8165820858)

Is that really true when you factor in the cost of the libraries? SASL
ANONYMOUS is roughly equivalent to default HTTP access model, and if
you probably already use an HTTP library, which is why the Twitter API
is so easy. If you're talking about something analogous to the Twitter
API, why is presence involved at all?

At the end of the day, I imagine the code is roughly equivalent
complexity wise, but the XMPP code will be extremely efficient in
comparison, since it is push instead of pull based.

> [jmissig](http://twitter.com/jmissig): huh. apparently there was an
  XMPP Summit in San Jose last year. I should've gone just to see what
  people are up to. [#](http://twitter.com/jmissig/status/8164863799)

Sorry that you missed it, but we'll be back again sometime in July I
suspect. We hold one XMPP Summit alongside
[FOSDEM](http://www.fosdem.org/) and one alongside
[OSCON](http://en.oreilly.com/oscon) every year.

> [ralphm](http://twitter.com/ralphm): With all the people coming and
  stuff I'd like to discuss, I already know XMPP Summit #8 will be way
  too short. [#](http://twitter.com/ralphm/status/8162850522)

> [quimgil](http://twitter.com/quimgil): If you are a developer
  knowing what XMPP and FOSDEM mean then
  [http://blog.xmpp.org/index.php/2010/01/developers-challenge-with-prizes/](http://blog.xmpp.org/index.php/2010/01/developers-challenge-with-prizes/)
  [#](http://twitter.com/quimgil/status/8062859698)

> [willsheward](http://twitter.com/willsheward): Schedule for the XMPP
  Devroom at FOSDEM this year has been published
  ([http://bit.ly/7FvL4N](http://bit.ly/7FvL4N)). Some interesting
  stuff there. [#](http://twitter.com/willsheward/status/8022275943)

The [8th XMPP Summit](http://xmpp.org/summit/summit8.shtml) is just
under two weeks away, and it's shaping up to be the best one yet. I'll
be there; will you?

> [tmray](http://twitter.com/tmray): @evan Any word yet on if messages
  in #identica opening as multiple users in #xmpp will be fixed?
  [#](http://twitter.com/tmray/status/8162478590)

[Identica](http://identi.ca) has been having a hell of a month for
XMPP uptime. I'm sure they'll fix it, but for those of us who live and
breathe via the XMPP interface, it has been painful.

> [novaspivack](http://twitter.com/novaspivack): everal people have
  said Twitter is going to be a protocol eventually. I agree. But why
  not just use XMPP? [#](http://twitter.com/novaspivack/status/8160477719)

> [stuartmalin](http://twitter.com/stuartmalin): IMHO: XMPP can't be
  used as a foundation to replace Twitter. It can be used for
  something a-kin to Twitter, but it would be
  different. [#](http://twitter.com/stuartmalin/status/8161346669)

[I beg to
differ](http://metajack.im/2008/09/15/an_xmpp_microblogging_stack/)
with stuartmalin. I'm with novaspivack; I think XMPP is a perfect base
for federated social media of almost any sort, especially something as
interactive as microblogging. I'd really like to know what you see as
the primary reason that XMPP is unsuitable for this task.

> [boterkoekjes](http://twitter.com/boterkoekjes): Any other scalable
  apps that use xmpp besides googlewave googlechat and facebook? fb
  chat is not working very well latelly? dont know
  why. [#](http://twitter.com/boterkoekjes/status/8118111102)

Sure. [Meebo](http://www.meebo.com) uses it to provide their chat
service, for example. Lots of ISPs offer IM services at their own
domains, and several of these installations are in the millions of
users. Really, though, isn't Google-esque scalability enough for a
protocol?

> [mickael](http://twitter.com/mickael): @gwapz Use an XMPP account +
  gateways. Benefit: Only one connection open for all your IM
  accounts. Check Talkr.IM for
  example. [#](http://twitter.com/mickael/status/8115989398)

I haven't used [Talkr.IM](http://talkr.im) yet, but it sounds like
Mickael and his team are continuing to make cool things on top of
[ejabberd](http://www.ejabberd.im). Gateways are one of the oldest
use cases of XMPP but remain some of the more popular.

> [communicating](http://twitter.com/communicating): Because of
  discussions w/ others about a data sharing layer I may b moving to
  xmpp soonr than later. Also really liking BOSH pubsub protocal
  [#](http://twitter.com/communicating/status/8099515326)

There's a [lot to
like](http://metajack.im/2008/07/02/xmpp-is-better-with-bosh/) about
[BOSH](http://xmpp.org/tech/bosh.shtml). It's one of the oldest long
polling protocols, and by far my favorite.

> [ronrat](http://twitter.com/ronrat): Installed OpenFire xmpp server
  this week for our company. Painless. Trillian and Spark
  clients. Recommend other clients? #openfire #trillian
  [#](http://twitter.com/ronrat/status/8096617746)

I don't generally think of
[Openfire](http://www.igniterealtime.org/projects/openfire/) as one of
the big XMPP servers, but a lot of people use it. [Pedro
Melo](http://www.simplicidade.org/) told me that it is one of the
easiest servers to set up and has a great web interface.

> [conikeec](http://twitter.com/conikeec): #followfriday Introducing
 @pradeep24 - Xtreme XMPP and Uber-Rails Meta Hacker
 [#](http://twitter.com/conikeec/status/8089320907)

[Pradeep](http://twitter.com/pradeep24) continues to do great things
with XMPP. His startup, [Presently](http://presentlyapp.com), is built
on top of XMPP. I've had the good fortune to meet him in person
several times, and you could do worse than to keep an eye on what he's
up to.

> [nyconyco](http://twitter.com/nyconyco):  days left to apply to XSF
  membership
  [http://wiki.xmpp.org/web/Membership_Applications_January_2010](http://wiki.xmpp.org/web/Membership_Applications_January_2010)
  [#](http://twitter.com/nyconyco/status/8064347798)

The [XMPP Standards Foundation](http://xmpp.org) is always looking for
new members. If you are interested in XMPP, please think about
applying.

> [paulscott56](http://twitter.com/paulscott56): #XMPP
  rocks. #justsaying Trying to formulate some additions to the
  microblogging over XMPP XEP quickly before some other
  work... [#](http://twitter.com/paulscott56/status/8059994142)

I wrote about the [microblogging
XEP](http://metajack.im/2010/01/23/the-inbox-files-2-microblogging/)
recently. I'm glad more people are thinking about this.

> [imoracle](http://twitter.com/imoracle): Finally, #Jaxl #BOSH
  support working with all enterprise level jabber servers :)
  [#](http://twitter.com/imoracle/status/8053999099)

[JAXL](http://code.google.com/p/jaxl/) is a new PHP library for
writing XMPP applications. I highly recommend
[Abhi's blog and XMPP tutorials](http://abhinavsingh.com/blog/).

> [thisismedium](http://twitter.com/thisismedium): The Medium XMPP
  server is coming together nicely thanks to @bwvr
  [http://bit.ly/7IX7Vk](http://bit.ly/7IX7Vk)
  [http://bit.ly/6EAtqR](http://bit.ly/6EAtqR)
  [#](http://twitter.com/thisismedium/status/8050701333)

This looks to be a new XMPP server in Python built on top of
[Tornado](http://www.tornadoweb.org/). Perhaps some competition for
[Ralph's](http://ralphm.net) [Twisted](http://twistedmatrix.com)-based
efforts.

> [LuigiMontanez](http://twitter.com/LuigiMontanez): Conceptualizing
  what an online, real-time disclosure system would look
  like. [http://bit.ly/citunited](http://bit.ly/citunited) XMPP?
  WebHooks? PubsubHubbub?
  [#](http://twitter.com/LuigiMontanez/status/8039158790)

XMPP improving politics? [Pubsub](http://xmpp.org/tech/pubsub.shtml)
could certainly be used to disseminate this kind of information. The
National Weather Service is already experimenting with XMPP for
weather information, so I don't see why it couldn't be put use
tracking the flow of money in politics.

