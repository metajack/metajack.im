---
layout: post
title: The Invisible Superhero
tags: [http, jabber, microblogging, xmpp]
time: "09:36"
extended: ":EXTENDED:"
---

It's no secret that I think XMPP and microblogging were [made for each other](http://metajack.im/2008/09/10/xmpp-microblogging-thoughts/).  Several people have disagreed stating that users will reject IM as an interface and are more comfortable with the Web.  Implicit in this argument is that the nature of the underlying transport must be visible to the end user, which is not true even with HTTP.  XMPP can make microblogging better by being an invisible superhero, and the users never have to know.

:EXTENDED:

## Transport Is Important

"Use the right tool for the job" and "to someone with a hammer, everything looks like a nail" are common expressions.  They proclaim that any given solution to a problem is not perfectly applicable to all problems.  This is true whether the solution is a mechanical tool, a piece of software, or just a transport protocol.  Using the correct tool is important.

Many things on the Internet are well transported by the HTTP protocol.  HTTP is such a generally useful tool that it could be considered one of the Internet's [simple machines](http://en.wikipedia.org/wiki/Simple_machines).  That said, it is not the best at everything, and [real time notification](http://metajack.im/2008/09/11/real-time-is-completely-different/) has better transports.  XMPP is the better tool for real time.

## Invisibility is Expected

Does the home owner care which tools were used to build their house?  Of course not.  Similarly, end users don't care how Web apps are built as long as they work.  The use of XMPP as a transport does not imply any particular interface for end users.

[Chesspark](http://www.chesspark.com) is built almost entirely on XMPP as a transport.  The end user's experience is primarily through a rich Web application.  The user is not exposed to the underlying transport, yet they still benefit from the transport's benefits.

IM, via XMPP, is a reasonable interface in its own right.  Many of us on [Identi.ca](http://identi.ca) use IM to read and post messages.  It is just one of the possible choices.  [XMPP BOSH](http://www.xmpp.org/extensions/xep-0124.html) enables standard Web interfaces as well.

[Twhirl](http://www.twhirl.org) and other desktop clients can use a variety of transports, and these transports all remain invisible.  Twhirl is an XMPP client, and it doesn't have a roster.  Even the IM parts are invisible there.

The goal of any application developer is to expose a useful and usable interface to their users regardless of the tools employed to create the app.  We're all used to doing this because it's part of our job.
