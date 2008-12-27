---
layout: post
title: "Get Twisted On XMPP - The Future Of Twisted Words"
tags: [code, jabber, python, server, twisted, xmpp]
time: "08:27"
extended: ":EXTENDED:"
---

One of the best libraries for writing XMPP clients and components is getting a lot better.  The team behind [Twisted Python](http://twistedmatrix.com) is gearing up to do some major improvements on `twisted.words.jabber`, which [Tofu](http://thetofu.com) and I use heavily at [Chesspark](http://www.chesspark.com/).

## Twisted Today

The XMPP facilities offered by Twisted are already excellent.  It supports client and component connections, XPath stanza matching, and, of course, the asynchronous design that powers all of Twisted.

Why aren't more people using Twisted for XMPP? One of the reasons is that Twisted's documentation is not the most complete, and Twisted Words is one of the less complete areas.  In order to get something up and running, it's almost a requirement to read the code and do a lot of trial and error.

## Turns Out There Are More Users Than You Think

[Duncan](http://oubiwann.blogspot.com/) announced the plan to improve Twisted's XMPP support in an [email to the Twisted Jabber list](https://mailman.ik.nu/pipermail/twisted-jabber/2008-September/000155.html).  Take a look at the name dropping of the people interested in Twisted XMPP (I've emphasized the company names).

> This interest was spearheaded by Jack
Moffitt of **Chesspark** and given additional momentum by Dhris DiBona of **Google**. Furthermore, we've received vocal support for XMPP
improvements from **Hydra Labs**, **Lucasfilm**, **Security Metrics**, and individual sponsors.

In addition to these, we've seen some interesting names turn up on the mailing lists.  There was a recent one from **id Software**.

There's no doubt XMPP is getting hot, and companies are diving in.

## Twisted Tomorrow

The [email](https://mailman.ik.nu/pipermail/twisted-jabber/2008-September/000155.html) outlines the basic roadmap, and it's pretty good, even if I did participate in its creation.

First, Duncan and others are planning to start writing tutorials and documentation for Twisted Words.  This is great news for everyone, as this is probably the library's biggest hurdle to adoption.  It is also great timing as last week I spent some time preparing a few tutorials myself for this blog.  I'll be posting them soon.

Next, the Twisted team is very excited about putting a basic server into the code base so that a developer writing an XMPP client or component can test locally with minimal fuss.

There was also talk of moving the [Palaver](http://www.onlinegamegroup.com/projects/palaver) project into Twisted Words which would give Twisted's XMPP server group chat support.

It's exciting!

## Learn More

We had a great discussion yesterday on IRC to kick off the effort, and you can read the [transcripts](http://twistedmatrix.com/trac/wiki/XMPPIRCTranscript20080903).  Duncan took some [notes on XMPP server design](http://twistedmatrix.com/trac/wiki/XMPPServerArchitecture) which make for a good introduction to the area.

If you already use Twisted XMPP, let us know!  We'd love the feedback and suggestions.


:EXTENDED:


