---
layout: post
title: Send GitHub Commits to XMPP Chat Rooms
tags: [code, git, github, jabber, python, twisted, wokkel, xmpp]
time: "23:16"
extended: ":EXTENDED:"
---

We're in the process of switching our development workflow from [Subversion](http://subversion.tigris.org) to [git](http://git.or.cz).  As part of this transition, we wanted to put notifications in our development group chat room.  [GitHub](http://github.com) has already standardized [Web hooks](http://github.com/guides/post-receive-hooks) and provides integration with IRC and other services.  I decided to implement an XMPP bot that listened for these HTTP push notifications and send commit information to the room.  

The code is available in my [commitbot repository](http://github.com/metajack/commitbot/tree/master).  Thanks to [Twisted](http://twistedmatrix.com) and [Wokkel](http://wokkel.ik.nu) this was surprisingly simple and occupies less than a hundred lines of code.  Commitbot will send both plain text and [XHTML-IM](http://www.xmpp.org/extensions/xep-0071.html) formatted messages.  The plain ones look like this:

<center><img src="http://metajack.im/images/gitbot-plain.png" alt="gitbot-plain.png" border="0" width="680" height="66" /></center>

The next part of this project is to implement a git hook script that can send these notifications just like GitHub does.

:EXTENDED:


