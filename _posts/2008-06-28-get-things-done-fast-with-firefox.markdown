---
layout: post
title: Get Things Done Fast With Firefox
tags: [firefox, jabber, osx, productivity, twisted, xmpp]
time: "11:15"
extended: ":EXTENDED:"
---

I've seen a few great posts lately about keyboard shortcuts and other small tweaks to make working with Firefox even better. These posts are often aimed at a general audience, so I thought it was time for a developer focused article. Below you will find a list of my favorite and most used Firefox shortcuts and hacks.  These are things I use constantly, every day, to do my development (and other) work.

<strong>Keyboard Navigation</strong>

Note that the following shortcuts are for Macs, but replacing <em>Cmd</em> with <em>Ctrl</em> should provide you with the Linux (or Windows) equivalent.

Everyone knows about <em>Cmd-T, Cmd-W</em>, I hope, which opens a new tab and closes a tab respectively.  You can also reopen the last closed tab with <em>Cmd-Shift-T</em>. Not only does this reopen the last closed tab, but it even opens it in the same spot where it used to be.

Scrolling through your tabs can be done with <em>Cmd-Opt-arrowleft/arrowright</em>, but I find this a little cumbersome.  It turns out Firefox has copied the friendlier <em>Cmd-Shift-[ </em>and<em> Cmd-Shift-]</em> which work in lots of other OS X programs (iChat, Safari, Terminal.app, and probably others).

<em>Cmd-L</em> takes you to the location bar; <em>Cmd-K</em> takes you to the search box.  One that I just found is <em>Cmd-uparrow/downarrow</em> to change the search engine used.  Want to search Wikipedia?  <em>Cmd-K</em>, <em>Cmd-Shift-downarrow</em> a few times and type.

The URL and search boxes both support <em>Enter</em> key combos to open the results in new tabs or windows.  I have my search box set to open searches in new tabs, but you can toggle this (regardless of which way the preference is set) by using <em>Cmd-Enter</em>.   You can open a new tab from the location bar with <em>Opt-Enter</em>.

By now I think most are familiar with the shortcuts for searching in a page (<em>/</em>, <em>Cmd-F</em>, and <em>'</em>), but you can also quickly scroll up and down with <em>Space</em> and <em>Shift-Space</em> which move a page at a time.

Another one that I use heavily is <em>Cmd-number</em> to jump to a specific tab.  I always keep some important tabs in the beginning like Gmail and MRTG graphs for machines at <a href="http://www.chesspark.com/">Chesspark</a>, so getting to these is a one-key action.

These keyboard shortcuts have allowed me to basically remove the mouse from the browser when I am working.  Most of the Web applications I use also have their own keyboard shortcuts as well. Gmail is particularly excellent in this regard; just hit <em>?</em> anywhere in Gmail for a list of available shortcuts.

<strong>The New URL Bar</strong>

I can't believe how great the new URL bar is.  If I want to write in this blog, I just type 'meta dash' and hit <em>Tab</em> (this takes me to the wordpress dashboard).   I use it constantly to find <a href="http://trac.edgewall.org/">Trac</a> bugs and wiki pages by typing a few characters of the bug title or number, and because Firefox 3 searches page titles as well as URLs, it finds what I want almost every time.

This works a lot like <a href="http://en.wikipedia.org/wiki/Quicksilver_(software)">Quicksilver</a>, which Mac people have been raving about forever (Quicksilver does this on files and has plugins for integrating other data like music albums).  I think this new URL toolbar will spur more innovation and similar features in other applications.

<strong>Keyword Searches</strong>

I already knew about keyword searches where you type 'amazon foo' into the URL bar and it will search Amazon (note that this may not be configured by default).  What I didn't know is that instead of writing the JavaScript required to add a new magic keyword, you can just right click in the search text box on whatever page and hit 'Add Keyword for this Search...' to do the same thing.  Firefox will even remember the state of other form elements.

This is highly useful for searching Trac instances.  Go to the <a href="http://twistedmatrix.com/trac/search">Twisted Trac search page</a>, fill out the advanced search parameters you like, and right click in the edit box and add a new keyword for the search.  Assuming you call it 'twisted' then you can now search Twisted's Trac by typing 'twisted adbapi' to find all the adbapi things.  You can do similar things for Python documentation, etc.

If you do want to get your hands dirty, a little JavaScript can do wonders.  Joe Hildebrand <a href="http://mail.jabber.org/pipermail/standards/2006-October/012535.html">wrote a little snippet</a> that makes 'xep' take you to the XEP list, but 'xep 124' takes you do the <a href="http://www.xmpp.org/extensions/xep-0124.html">XEP-0124 page</a>.  I use this a lot, and I copied this to add 'ticket N' searches for the Chesspark internal Trac system.  Anytime I see a ticket number, I can pull it up directly. If I want to file a new ticket, 'ticket' takes me to the new ticket page.

<strong>Go Forth and Be More Productive</strong>

The <a href="http://www.mozilla.com/en-US/firefox/">Firefox</a> team deserves a huge amount of gratitude for making a browser that is so keyboard friendly and extensible. It pains me to use any other browser now because most of them don't have this kind of attention to detail.

Thank you, Firefox, you help me get things done fast.

Many of these tips I read about on various blogs.  Here's a short list of articles that inspired this post:
<ul>
	<li><a href="http://lifehacker.com/software/feature/hack-attack-mouseless-firefox-139495.php">Lifehacker: Mouse-less Firefox</a></li>
	<li><a href="http://i-stuff.blogspot.com/2008/06/cool-features-in-firefox-3.html">i-Stuff: Cool Features in Firefox 3</a></li>
	<li><a href="http://lifehacker.com/software/email-apps/ask-lifehacker-gmail-as-default-mail-program-129818.php">Lifehacker: Gmail as default mail program</a></li>
</ul>

:EXTENDED:


