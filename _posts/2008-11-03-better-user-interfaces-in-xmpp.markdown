---
layout: post
title: Better User Interfaces In XMPP
tags: [jabber, startups, ui, xmpp]
time: "16:21"
extended: ":EXTENDED:"
---

User interfaces don't just mean pretty graphics.  Every command line tool you use has a user interface, and some of these are much better than others.  [XMPP](http://www.xmpp.org) services are starting to have user interfaces as well, and these continue to improve.  Just today one such improvement surprised and impressed me, and I hope that it becomes more widely adopted.  The idea is very simple; respond to presence subscription requests with instructions on how to interact with the service.



:EXTENDED:

Many services that have chat as their interaction method required presence subscription.  The first step to using one of these services is to add the JID of the service to your roster.  Doing this sends a presence subscription request to the service.  Most services just approve the subscription and perhaps create a reciprocal subscription, and then wait for the user to do something.

They could do so much more than this.  

When the user requests this presence subscription, this is the perfect time to send them some basic information on how to use the service and where to go for more information.  The interaction then becomes really easy; first, add the service, and next, respond to the service's greeting with some command.  Not only does this provide a quick introduction, but it saves the user of the service from having to find the roster item and click on it to initiate a conversation.  Since the service initiates the conversion as soon as it knows about the interested user, no further action needs to be taken for the initial experience.

Credit for this goes to [Dustin](http://bleu.west.spy.net/~dustin/) and his [whatsup](http://www.github.com/dustin/whatsup) service.  I original encountered it testing a new project that he an [Ken](http://www.kensheppardson.com) are working on that will be announced soon.

The change is pretty small, but the improvement to the experience is huge.  This is just a chat based UI; just think how much more could be done when more sophisticated interaction methods.  What will good [pubsub](http://www.xmpp.org/extensions/xep-0060.html) UIs look like?
