---
layout: post
title: "XMPP Case Study Interview: Drakontas"
tags: [xmpp, jabber, case study, drakontas, mobile, strophe]
time: "11:07"
extended: ":EXTENDED:"
---

XMPP is everywhere. Did you have any idea that your local SWAT team
might be using XMPP for tactical coordination, or that the same
technology might be used to allow friends and family to track and
share location with each other? It always amazes me where XMPP will
turn up, but [Ilya](http://www.ilyabraude.com) and his team at
[Drakontas](http://www.drakontas.com) have used the technology to
great effect with their two products, [Smyle](https://smylenow.com/)
and
[DragonForce](http://drakontas.com/software/dragonforce/overview.html).

I often meet people doing amazing things with XMPP technologies, and
through these case study interviews, I want to highlight the great
work that these people and companies are doing. This is the second
case study interview (see the first one on
[Cabulous](http://metajack.im/2010/01/05/xmpp-case-study-interview-cabulous/)),
and I really hope you are enjoying these as much as I am.

[Ilya Braude](http://www.ilyabraude.com) is our guest for this
interview, and he is the lead software engineer for Drakontas, working
on both their [Smyle](https://smylenow.com) and
[DragonForce](http://drakontas.com/software/dragonforce/overview.html)
products.

<p style='text-align:center'>
<img src='/images/smyle1.jpeg' width='180' height='300'>
<img src='/images/smyle2.jpeg' width='180' height='300'>
<br>
<img src='/images/dragonforce1.png' width='512' height='324'>
<img src='/images/dragonforce2.png' width='523' height='324'>
<img src='/images/dragonforce3.png' width='523' height='324'>
</p>

:EXTENDED:

## Drakontas

<strong>Jack: What is Smyle?</strong>

Ilya: Smyle is a group-based social collaboration application that
allows you and your friends to interact with each other to plan or
coordinate around specific events.

It does this by allowing group members to chat, share location, and
pictures.  All pictures and maps are also instantly turned into shared
whiteboard sessions, allowing annotations and icon placement.

<strong>Jack: Can you give some examples of how people are starting to
use Smyle?</strong>

Ilya: Smyle in being used in various ways.  First, it's being used as
a real-time location tracking service.  People are using it to track
each other as they are arriving at the same destination, without
having to call or text each other to get status updates.

Then, they can use the whiteboarding features to enhance that
experience.  For example, I might draw a path for you to take on the
map, to show you exactly where I am and how to get to me and use icons
to mark destinations and places of interest.

The chat feature is also heavily utilized, probably because people are
accustomed to it.  However, the other collaborative features were
designed to minimize overt chat and allow users to collaborate
naturally.

<strong>Jack: You currently have a version for the Web and for Android
phones. Are other implementations planned?</strong>

Ilya: Yes, we are constantly being asked if an iPhone version is
available, and we are working on it.  There's no planned release date
yet, but it's definitely coming.

<strong>Jack: It seems like the friends, chat, and collaboration are
all great places for XMPP. How much of the system is powered by
XMPP?</strong>

Ilya: Because the application must be real-time and collaborative,
XMPP is a natural choice that has worked very well for us.  Almost all
of the communication is over XMPP, with the exception of out-of-band
image downloads, which use HTTP.

In fact our protocols are based on the PubSub specification.  We have
implemented custom components on the server side which masquerade as
PubSub services, but perform business logic operations on the
payloads.

The whole XMPP ecosystem has been great for this: everything from
libraries for the browser (we use Strophe), to the excellent work that
has been done with XMPP and Twisted, to stable XMPP servers that are
at the core of the messaging bus.

<strong>Jack: It's great that you were able to map most of the
functionality onto well known XMPP extensions. Did all of the
functionality map this way, or did you use some custom extensions as
well?</strong>

Ilya: We have been trying to stick to existing specifications as much
as possible for several reasons.  Client (and server) development is
easier if we reuse existing library support for PubSub and Data Forms,
and it would be easier for third party integration if we decide to
open an API in the future.  So we have been able to use existing
specifications in creative ways.  For example, a whiteboard is a
PubSub node, where each item in the node is an annotation or icon.  We
use Data Forms for structured data and configuration.  The
customization comes from how clients and servers interpret these
existing protocols.

<strong>Jack: Did you find that using existing protocols, even if
library support wasn't available, made you more productive?</strong>

Ilya: A lot of smart people have spent time designing the protocols,
so it's great to be able to rely on well-written and thorough
specifications.  We don't have library support on all platforms.  In
many cases, we've had to implement our own, and have contributed the
code back to the open source community.  This allowed us to
concentrate on what was important for our application rather than the
lower-level protocols.  We did face some challenges with this approach
and have had to come up with interesting ways to model information.
However, in the end, I believe reusing existing work was the right
approach.

<strong>Jack: You've given some great reasons for choosing XMPP. Were
there other technologies that you evaluated as well?</strong>

Ilya: The first consideration was, of course, to implement our own.
And having done so in a previous application, we decided that it
wasn't the best choice.  We've also briefly looked at other messaging
platforms such as JMS, but it was quickly obvious that they weren't a
good fit.  XMPP was simple enough to understand, and develop with,
especially because we could see wire traffic and compare it with
existing working implementations.  So it was a natural choice.

I should also note that XMPP servers offer a lot out of the box,
especially Multi-User Chat and PubSub.  Our initial implementations
used built-in server implementations, which we replaced with custom
components as our requirements and feature set grew.

<strong>Jack: Was this your first time using XMPP?</strong>

Ilya: Prior to this application and another application that we have
also built with XMPP, I've had no experience with it at all.  Needless
to say, there was a lot of time spent reading specs!

<strong>Jack: Did it take long to get up to speed with XMPP? Which
parts gave you the most trouble?</strong>

Ilya: One of the first things that I did with XMPP was implement a
J2ME client from the ground up.  That didn't take too much time.  One
of the initial challenges was determining what server features were
available and how we could use them correctly.  And also we've had to
figure out what our server of choice actually implemented and any
quirks it had.

<strong>Jack: When I first met you, you showed me another project that
your company created. It seems like something you'd see on TV shows
like 24. Can you tell me a little bit about DragonForce?</strong>

Ilya: DragonForce is an application for law enforcement, first
responders, and tactical teams.  It allows for rich real-time
information exchange between the units in the field and command
centers.  We've worked a lot with SWAT teams, and routinely
participate in tactical exercises with them.  The state of the art in
communications is usually a voice radio.  DragonForce allows teams and
individuals to track each other on a map, send text messages, and
share annotatable pictures, floor plans, and maps.

There are numerous advantages to this type of system.  For example,
sending a picture of a suspect augmented with a text description
immediately to everyone in the field is far better than sending a
description over the radio.  The guys in the field can take pictures
using their mobile devices and send them to the commander, providing
valuable visibility into a situation.

We have a mobile application that runs on rugged handhelds, and a
command center application that is a web-based application.  In fact,
Smyle is our adaptation of that technology to the consumer space.

<strong>Jack: All the same features from Smyle are there as well
right? Real-time location updates on a map, whiteboarding on
floor plans, etc?</strong>

Ilya: Yes, all of these features are in DragonForce as well.
Floorplans turn into whiteboards so that, for example, as rooms are
cleared in a building they can be marked off silently and quickly
without radio chatter.

<strong>Jack: Will you be using XMPP in future projects? Do you
recommend it to others?</strong>

Ilya: I would absolutely recommend it, and we'll keep building
collaboration software using XMPP.  Besides the technology, there's a
great and active community that has helped us a lot, and I'm sure will
help others as well.

## Technical Details

Smyle and DragonForce are both custom XMPP clients. The websites both
use the <a href='http://code.stanziq.com/strophe'>Strophe.js</a>
library for XMPP communication over <a
href='http://xmpp.org/about-xmpp/technology-overview/bosh/'>BOSH</a>. The
mobile clients use native connections.

Ilya has made many of his own plugins for Strophe.js as well,
including ones for [Data
Forms](http://xmpp.org/extensions/xep-0004.html),
[PubSub](http://xmpp.org/about-xmpp/technology-overview/pubsub/),
[Multi-user
Chat](http://xmpp.org/about-xmpp/technology-overview/muc/), [Service
Discovery](http://xmpp.org/extensions/xep-0030.html), and roster
management.

The XMPP server used for DragonForce is <a
href='http://www.igniterealtime.org/projects/openfire/'>Openfire</a>,
but the Drakontas team have switched to <a
href='http://prosody.im'>Prosody</a> for Smyle.

They have written a number of custom components in Python using
[Wokkel](http://wokkel.ik.nu/) and
[Idavoll](http://idavoll.ik.nu/). Having the components being external
to the server makes them portable across the two different servers.

## My Thoughts

I met Ilya at the XMPP Summit in Brussels in 2010. He completely
floored me with his demo of DragonForce, and he followed up later in
the summit with some great ideas in his Strophe.js plugins. He and his
team have done some amazing things, both with web technology in
general and with XMPP specifically.

I can hardly believe that the same technology platform they've built
powers both such a niche use case and a consumer application, but once
you use the products, it makes a lot of sense.

You can try out Smyle yourself right now [on the
web](https://smylenow.com) or with their [Android
client](https://market.android.com/details?id=com.smyle).

If you have some questions for Ilya, please leave a comment. I'll make
sure he sees them.
