---
layout: post
title: XMPP Is Better With BOSH
tags: [ajax, bosh, chesspark, comet, http, jabber, punjab, speeqe, strophe, xmpp]
time: "22:21"
extended: ":EXTENDED:"
---

In order to build XMPP applications inside web browsers, the <a href="http://www.xmpp.org/">XSF</a> created the <a href="http://www.xmpp.org/extensions/xep-0124.html">Bidirectional-streams Over Synchronous HTTP</a> (BOSH) specification.  This document specifies the interface for a server side connection manager which holds your XMPP connections open and uses <a href="http://en.wikipedia.org/wiki/Comet_(programming)">Comet</a> to mimic a two way pipe to the browser.  Having used BOSH-based clients as my primary Jabber interface for almost two years, I have come to believe that BOSH leads to more reliable clients.

<strong>BOSH Hides An Unreliable Connection</strong>

BOSH typically holds your connection for a few minutes while there is no activity.  The great thing about this is that even if the underlying Internet connection is unreliable, your BOSH connection will live on.

I'm currently writing this post in rural Minnesota where my Internet connection goes up and down once every 10 minutes or so.  I have not been able to keep iChat (either AIM or Jabber) connected all day, but my <a href="http://www.speeqe.com/">Speeqe</a> client disconected only once.  Of course, the Speeqe client is still in heavy development, so I'm not sure if that was related to the spotty connection.

The practical application of this is that I can sleep my laptop and go to a new location without being disconnected, as long as I open it back up before the server times out my BOSH session.  It will also gracefully handle the case where I switch out one WiFi connection for another.

<strong>BOSH Does Not Lose Data</strong>

I'm not sure if other BOSH servers support this, but <a href="http://www.butterfat.net/wiki/Projects/PunJab">Punjab</a> will cache and resend request responses. If one of the responses fails to reach the client, the client will get the same data back after replaying the request.  This means that even though I switch IPs or repeatedly lose connectivity, I never lose any data.  The worst thing that has ever happened on my BOSH sessions is chats have arrived out of order, but even this occurrence is rare.

This is a lot different from a straight TCP connection.  If I lose connectivity while chatting in iChat, I have no idea if I missed part of the conversation, and the server cannot replay data to me from a known point.  I usually have to ask people to paste the chat history starting from the last message I know I received.

<strong>BOSH Streams Are Compressed For Free</strong>

Since most web servers and proxies compress outgoing text data with GZip, BOSH streams can get this compression for free in the server-to-client direction.  This means faster data transfers over slow links without having to implement or worry about compression in the client.

Unfortunately in the Web browser case, sending data to the BOSH server compressed is not automatic, and implementing GZip in JavaScript may not be a workable solution. The compression benefit is only one sided due to these constraints.  Amusingly, this creates a bandwidth asymmetry very similar to cable and ADSL connections.

How many TCP based XMPP clients currently support stream compression?  I think not many.  In contrast, all current BOSH clients have at least one sided stream compression out of the box.

<strong>BOSH Is Firewall Friendly</strong>

Since BOSH operates over HTTP, it works in many places that direct TCP connections do not.  I have stayed in several hotels which blocked long lived TCP connections of any type, and many corporate environments do not let port 5222 through the firewall.  BOSH gets around all of this quite nicely.

<strong>The Downside of BOSH</strong>

These benefits come with a small price, and part of that price is the added latency of involving the HTTP protocol.  BOSH in the browser is a worst case for this latency due to connection limitations, but even here performance is pretty good.  We've had millions of real-time chess games played over BOSH, and the experience is very close to the same as the native <a href="http://www.chesspark.com/">Chesspark</a> client.

This latency is further reduced if HTTP pipelining is used, or if your application can use a BOSH hold value larger than 2 which is the limit of most browsers.

The other part of the price is the extra bandwidth consumed by the overhead of HTTP requests.  Tuning the client and Web server to avoid useless HTTP headers can remove a lot of these issues, as can the aforementioned stream compression.  It would make Strophe a lot more efficient if Web browser headers could be controlled from the JavaScript engine.

<strong>Native Clients and BOSH</strong>

It would be interesting for native clients to support BOSH as a transport method alongside direct TCP connections.  This would reap the benefits of firewall friendliness and a more reliable connection if Internet connectivity is poor.  Since non-browser clients do not suffer the arbitrary restrictions on HTTP connections, most of the latency problems can be eliminated, and it would be easy to make stream compression work in both directions.

We've created a Twisted BOSH client interface for testing Punjab and various Chesspark services, and if people are interested, I can write more about this and publish the code.

<strong>Get BOSHing</strong>

What are you waiting for?  Go read the BOSH specification in <a href="http://www.xmpp.org/extensions/xep-0124.html">XEP 124</a>.  Go write an interesting XMPP Web application with <a href="http://metajack.im/2008/06/30/strophe-preview-xmpp-in-javascript/">Strophe</a>.  Go check out a BOSH server like <a href="http://www.butterfat.net/wiki/Projects/PunJab">Punjab</a>.  Go run <a href="http://thetofu.livejournal.com/71339.html">BOSH in the cloud</a>.

:EXTENDED:


