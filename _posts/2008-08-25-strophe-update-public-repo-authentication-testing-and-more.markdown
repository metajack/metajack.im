---
layout: post
title: "Strophe Update: Public Repo, Authentication Testing, and More"
tags: [c, code, jabber, javascript, library, libstrophe, lua, software, strophe, strophejs, testing, xmpp]
time: "00:42"
extended: ":EXTENDED:"
---

It's taking a bit longer than planned to whip Strophe into releasable shape, but work is progressing well.  Since the last update, I have made a <a href="http://code.stanziq.com/strophe">new and better Trac instance</a> for the project, made a <a href="http://code.stanziq.com/svn/strophe/">public SVN repository</a> for the code, added SASL ANONYMOUS support to both libstrophe and Strophe.js, fixed DIGEST-MD5 authentication with ejabberd, did compatibility testing for <a href="http://code.stanziq.com/strophe/wiki/LibstropheCompatibility">both</a> <a href="http://code.stanziq.com/strophe/wiki/StropheJsCompatibility">libraries</a>, and wrote up a <a href="http://code.stanziq.com/strophe/browser/trunk/strophejs/examples">basic Strophe.js example</a>.  Still to come are TLS fixes for libstrophe, porting the libstrophe documentation to Natural Docs, working around a <a href="http://code.stanziq.com/strophe/ticket/4">BOSH bug with Tigase</a>, and writing up some examples.

On a related note, <a href="http://matthewwild.co.uk">Matthew Wild</a> is working on an <a href="http://matthewwild.co.uk/projects/verse/verse_doc.xml">XMPP library for Lua</a> built on top of libstrophe.

Also, <a href="http://metajack.im/2008/08/08/learn-about-xmpp-at-sxsw-2009/">remember to vote</a> for my XMPP <a href="http://panelpicker.sxsw.com/ideas/view/1934">talk</a> and <a href="http://panelpicker.sxsw.com/ideas/view/1933">panel</a> at SXSW 2009.

UPDATED 8/26: It turns out Tigase and Openfire are smarter than the other XMPP servers with DIGEST-MD5 authentication, and that it wasn't a bug at all.  My apologies (kudos) to the Tigase and Openfire teams.  The issue is now fixed in trunk.

:EXTENDED:


