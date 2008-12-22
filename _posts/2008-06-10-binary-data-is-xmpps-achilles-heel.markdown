---
layout: post
title: Binary Data is XMPP's Achilles Heel
tags: [chesspark, code, jabber, xmpp]
time: "10:13"
extended: ":EXTENDED:"
---

A few months back, our users started to complain that clocks were skipping a lot and that chat messages were getting delayed.  After a little bit of digging we realized the root cause: avatars.  A few random users had avatars that were quite large (relative to normal xmpp stanzas). Because a TCP connection can only be retrieving one XMPP stanza at a time, all other incoming stanzas were blocked until the avatar was fully downloaded.  This is bad news for applications that users expect to be very low latency like a game.

<strong>An Analogy To Multitasking</strong>

XMPP is like cooperative multitasking.  Each stanza must wait until the previous stanzas have been received before it can be sent.  There is no way to preempt a stanza to achieve a fairer usage of the connection.  This means that large stanzas do not play nicely and cause other stanzas to hang.  The only way to achieve balance is for all the stanzas to limit themselves to some small size and not consume the whole connection for long periods of time.

If all the stanzas don't cooperate to achieve a low latency for stanza handling then you get a poor experience for users.  This is similar to that of OS 9 or Windows 3.x when one application didn't cede control as often as it should.  This problem becomes a lot worse as the connection speed declines.  Our broadband users were able to notice this with avatars under 20kB in size.

<strong>A Proposed Solution</strong>

The only real solution without retooling the entire XMPP spec is to enforce a small maximum stanza size.  I suggest 4kB, which is about 1 second for a dialup user.  If any stanza would be bigger than 4kB, then it needs to be chunked and sent out as a group of stanzas, each of which is 4kB or less.

The in-band bytestreams specification (<a href="http://www.xmpp.org/extensions/xep-0047.html">XEP 47</a>) already exists to do exactly this kind of thing.  Unfortunately it is used mostly for file transfers and not for more common tasks like avatars and large messages.  The community needs to address this by building in-band bytestream support into places where large data may occur.  It should be part of the avatar specifications (<a href="http://www.xmpp.org/extensions/xep-0084.html">XEP 84</a> and the historical <a href="http://www.xmpp.org/extensions/xep-0153.html">XEP 153</a>).  There should be a XEP documenting how clients would send large messages to each other.  New specifications like the data element spec (<a href="http://www.xmpp.org/extensions/xep-0231.html">XEP 231</a>) need to be more clear about their use cases and the consequences of abuse.

<strong>A Workaround For Now</strong>

Until we can address some of the specification problems and client and server support issues, we will have to work around the large stanza issues.  Thankfully, large stanzas in common use are mostly limited to avatars (roster queries are not usually large unless you are <a href="http://stpeter.im/">Peter Saint-Andre</a> and they happen once at the very start of a connection where high latency is not a big issue).  For these the best workaround is to request them out of band.

At <a href="http://www.chesspark.com/">Chesspark</a> we have built a web service that the clients can use to request avatars based on the JID.  We already had this built before we noticed the large stanza problem due to limitations of JavaScript.  JavaScript does not allow you to take binary data you've gotten over the XMPP connection and make that into a displayable image.  It is necessary to publish this data to some web service that returns an image url that JavaScript can use.  It is a short path from there to request the data directly from the web service based on the JID, since that saves an entire round trip to the client.  Once we discovered avatars were causing problems for our users, we modified the native client to do the same thing, and the problem disappeared.

<strong>Final Thoughts</strong>

Large stanzas and XMPP don't combine well, and this fact seems not well enough known in the XMPP community.  I think the primary reason for this is that most XMPP clients today are only scratching the surface of what is possible with the platform.  As more advanced functionality is used, more and more people will discover this issue as we did.

Let's address this issue now before it becomes a bigger issue by:
<ul>
	<li>Limiting stanza size to some small value (4kB)</li>
	<li>Sending large bits of data in chunks with in-band bytestreams (<a href="http://www.xmpp.org/extensions/xep-0047.html">XEP 47</a>)</li>
	<li>Retooling XEPs like <a href="http://www.xmpp.org/extensions/xep-0084.html">User Avatar</a> and <a href="http://www.xmpp.org/extensions/xep-0060.html">Pubsub</a> to support the use of in-band bytestreams</li>
	<li>Making it obvious in new XEPs (like <a href="http://www.xmpp.org/extensions/xep-0231.html">XEP 231</a>) that they need to be used with care and cooperate with small stanzas</li>
	<li>Upgrading clients and servers to support in-band bytestreams for large stanzas</li>
	<li>Working around the problem while we figure out canonical solutions so that our users have the best experience possible</li>
</ul>
Let's make sure that XMPP continues to improve, since it <em>will</em> take over the world.

:EXTENDED:


