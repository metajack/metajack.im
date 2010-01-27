---
layout: post
title: Spice Up Your Blog with a Collecta Widget
tags: [collecta, xmpp, jabber, strophejs]
time: "00:01"
extended: ":EXTENDED:"
---

Today, [Collecta](http://collecta.com) announced our new [widget
system](http://widget.collecta.com), which allows anyone to easily
embed real-time searches on any topic virtually anywhere. Here is an
example for an XMPP search:

<iframe style="border: medium none; width: 300px; height: 600px; overflow: hidden;" src="http://widget.collecta.com/widget.html?query=XMPP&amp;alias=&amp;headerimg=http%3A%2F%2Fmetajack.im%2Fimages%2Fxmpp-horiz.png&amp;stylesheet=http%3A%2F%2Fmetajack.im%2Fmisc%2Fxmpp_widget.css&amp;delay=" id="widgetframe" frameborder="0" scrolling="no"></iframe>

And the code you can use to add this to your page:

<code>
<pre name='code' class='html'>
&lt;iframe style="border: medium none; width: 300px; height: 600px; overflow: hidden;" src="http://widget.collecta.com/widget.html?query=XMPP&amp;alias=&amp;headerimg=http%3A%2F%2Fmetajack.im%2Fimages%2Fxmpp-horiz.png&amp;stylesheet=http%3A%2F%2Fmetajack.im%2Fmisc%2Fxmpp_widget.css&amp;delay=" id="widgetframe" frameborder="0" scrolling="no">&lt;/iframe>
</pre>
</code>

There is even an easy-to-use [Collecta WordPress
plug-in](http://wordpress.org/extend/plugins/collecta-search/installation/).

:EXTENDED:

This widget is a full-fledged XMPP client, receiving notifications
from Collecta's pubsub service. It is powered, of course, by
[Strophe.js](http://code.stanziq.com). You'd probably never notice
that it uses XMPP; it is completely invisible in this application, as
it should be. The users only care that it is fast and the results are
near-instantaneous.

Over the last week we've had a chance to watch our hard work put to
the test by MySpace, who have been experimentally embedding Collecta
widgets on pages like [Today on
MySpace](http://myspace.com/todayonmyspace) and [MySpace Breaking
news](http://myspace.com/breakingnews). The XMPP traffic generated has
been many times our previous maximum throughput, but the system as
handled it quite gracefully. The one issue that eventually cropped up
was not a fault of XMPP or a browser bug; it was just a small bug in
our own subscription handling code.

Over ten years of design and implementation experience is baked into
XMPP and its extensions, and it shows when it performs so well and
makes these difficult tasks possible and *almost* easy.
