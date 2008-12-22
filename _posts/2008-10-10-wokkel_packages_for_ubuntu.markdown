---
layout: post
title: Wokkel Packages For Ubuntu
tags: [intrepid, jabber, python, twisted, ubuntu, wokkel, xmpp]
time: "21:07"
extended: ":EXTENDED:"
---

I've dusted off my packaging skills to create Ubuntu/Debian packages for [Wokkel](http://wokkel.ik.nu).  These are make straight from [Wokkel's trunk](https://svn.ik.nu/wokkel/trunk), and I will update them periodically to track its changes.  Now there's no excuse not to start playing with the code!

You can find the package `wokkel` in my [Launchpad](http://launchpad.net) personal package archive.  Add the following lines to `/etc/apt/sources.list`, and then you can `apt-get update` and `apt-get install wokkel`.

    deb http://ppa.launchpad.net/metajack/ubuntu intrepid main
    deb-src http://ppa.launchpad.net/metajack/ubuntu intrepid main

Enjoy!


:EXTENDED:


