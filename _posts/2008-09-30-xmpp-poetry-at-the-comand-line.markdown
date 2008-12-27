---
layout: post
title: XMPP Poetry At The Comand Line
tags: [code, jabber, python, twisted, wokkel, xmpp]
time: "23:04"
extended: ":EXTENDED:"
---

There is an unfortunate lack of command line tools for interacting with XMPP services.  Sure we have things like [sendxmpp](http://sendxmpp.platon.sk/), but where are the tools like DNS's [dig](http://www.linux.com/articles/113992) or HTTP's [curl](http://curl.haxx.se/)?  Inspired by [Wokkel](http://wokkel.ik.nu), I've decided to start making some basic tools.  Please welcome [Poetry](https://launchpad.net/poetry) to the world, a collection of small tools for interacting with XMPP from the command line.

:EXTENDED:

## A Small Start

Currently I have two tools in the works, but I hope to add more based on user feedback and my own personal needs.  You can grab the latest code at the [Poetry Launchpad page](https://launchpad.net/poetry) and start playing around with them.  These tools are based on [Ralph Meijer's](http://ralphm.net) [Wokkel](http://wokkel.ik.nu) project.  You will need Python 2.5, [Twisted](http://twistedmatrix.com) 8.x and the latest Wokkel release in order to use these tools.

## disco Is Not Dead

The first tool is called **disco**, and it is all about [service discovery](http://xmpp.org/extensions/xep-0030.html).  Do you want to find out what services are supported at your server:

    $ disco --info user@host - jabber.org
    DISCO INFO FOR jabber.org:
      IDENTITIES:
        anonymous (category: pubsub, type: pep)
        ejabberd (category: server, type: im)
      FEATURES:
        commands
        disco#info
        disco#items
        disco#publish
        http://ejabberd.jabberstudio.org/protocol/configure
    ...

You can also use `disco --items` to find what other services are available.  `disco --recursive --info --items` is also planned but not currently working.  It will show the information for the current resource, then enumerate the items and show their information recursively.

This is great for checking which [XMPP PubSub](http://xmpp.org/extensions/xep-0060.html) features are supported by your favorite server.

## pubsub-config Makes A Great Node

The second tool is **pubsub-config**.  This tool creates, configures, and displays the configuration of pubsub nodes.

Currently, pubsub-config is not yet fully operational, although it can already create pubsub nodes.  I'm still working out the kinks of the pubsub node configuration form.  Feel free to pitch in and help!

## Future Ideas

I can think of a lot of tools that would be useful:

* **muc-config** - Create and configure multi-user chat rooms.
* **jid-register** - Create an account on an XMPP server.
* **xepman** - Easy access to XEPs similar to the classic `man` command.
* **pubsub-publish** - Send new items to pubsub nodes.
* **xmpp-ping** - Ping services on the federated network, perhaps sussing out s2s issues.

Please download the code and give it a try.  If you have ideas for more tools, please share them in the comments.
