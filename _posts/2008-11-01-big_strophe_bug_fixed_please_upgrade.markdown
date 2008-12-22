---
layout: post
title: Big Strophe Bug Fixed; Please Upgrade
tags: [code, jabber, javascript, strophe, xmpp]
time: "21:04"
extended: ":EXTENDED:"
---

[Strophe](http://code.stanziq.com/strophe) has been getting a lot of new users lately, and thanks to one of them, I've just found and fixed a pretty major bug.  If you are using strophe.js currently, please upgrade to the latest version in the [repository](http://code.stanziq.com/svn/strophe).

The issue is that when an `XMLHttpRequest` gets aborted, a new request was created with the same data but not immediately posted.  This is normally fine since it will still get posted on the next pass, but in a few cases this caused Strophe to cease data processing.  The error was introduced when I refactored the code from the older version;  I deleted one too many lines by mistake.

Bugs aside, all the users seem quite happy.  Thanks to all of you for helping us make Strophe the most robust XMPP library around.

:EXTENDED:


