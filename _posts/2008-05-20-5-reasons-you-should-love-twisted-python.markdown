---
layout: post
title: 5 Reasons You Should Love Twisted Python
tags: [chesspark, code, jabber, python, twisted, xmpp]
time: "22:33"
extended: ":EXTENDED:"
---

<a href="http://www.chesspark.com/">Chesspark</a> has recently made a donation to the <a href="http://twistedmatrix.com/trac/wiki/TwistedSoftwareFoundation">Twisted Software Foundation</a> and become a founding sponsor.  You can see our logo on the <a href="http://www.twistedmatrix.com/">front page</a> along side other companies which also use Twisted like LucasFilm, Sun Microsystems, and Zenoss.

We use Twisted for almost everything at Chesspark.  Not only is it used by <a href="http://www.onlinegamegroup.com/projects/palaver">Palaver</a> (our <a href="http://www.xmpp.org/extensions/xep-0045.html">MUC</a> component), <a href="http://www.butterfat.net/wiki/Projects/PunJab">Punjab</a> (our <a href="http://www.xmpp.org/extensions/xep-0124.html">BOSH</a> interface) and <a href="http://idavoll.ik.nu/">Idavoll</a> (a <a href="http://www.xmpp.org/extensions/xep-0060.html">pubsub</a> component), but we also use it for all our internal components that implement chess logic, game pairing, and game searching.

Here are 5 reasons you should use and love Twisted:

<ol>
<li>
The team is serious about code quality and their methods are inspiring.  Read about their <a href="http://divmod.org/trac/wiki/UltimateQualityDevelopmentSystem">Ultimate Quality Development System</a> and their <a href="http://twistedmatrix.com/trac/wiki/ReviewProcess">code review process</a>.
</li>
<li>
The team is extremely responsive to feedback, questions and bug reports.
</li>
<li>
Deferreds take some getting used to, but they are awesome.
</li>
<li>
The @defer.inlineCallbacks decorator makes using deferreds even better.
</li>
<li>
twisted.words makes writing XMPP components and clients a breeze.  Twisted even makes testing these components fairly easy.
</li>
</ol>

:EXTENDED:


