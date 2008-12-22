---
layout: post
title: Ejabberd Snapshot Packages Now Available
tags: [code, ejabberd, jabber, launchpad, ubuntu, xmpp]
time: "15:02"
extended: ":EXTENDED:"
---

I've just finished packaging [ejabberd](http://www.ejabberd.im) 2.1.0 straight from the [ejabberd Subversion repository](http://svn.process-one.net/ejabberd/trunk).  This snapshot version will be updated to keep abreast of changes in the repository.  One nice thing about 2.1.0 over previous 2.0.x versions is that it seems to use less memory.

You can find the packages in my [Launchpad PPA](https://launchpad.net/~metajack/+archive), or you can add the following sources to your `/etc/apt/sources.list`

    deb http://ppa.launchpad.net/metajack/ubuntu intrepid main
    deb-src http://ppa.launchpad.net/metajack/ubuntu intrepid main

and install with `apt-get`:

    apt-get install ejabberd-snapshot

Enjoy!


:EXTENDED:


