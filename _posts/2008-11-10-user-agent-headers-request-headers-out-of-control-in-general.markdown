---
layout: post
title: User Agent Headers? Request Headers Out Of Control In General
tags: [bosh, http, jabber, web, xmpp]
time: "22:43"
extended: ":EXTENDED:"
---

Web browsers send a lot of HTTP request headers whenever they talk to a Web server.  For the most part these represent a negligible amount of the total data transferred, but in today's Web 2.0 world of small, fast AJAX requests, the request headers are starting to dwarf the data sent.  [DeWitt Clinton](http://blog.unto.net) recently noted that [user agent headers are out of control](http://blog.unto.net/programming/user-agent-headers-are-out-of-control/), but really the same can be said for the entire set of headers as well.  Let's see an example.



:EXTENDED:

[XMPP](http://www.xmpp.org) [BOSH](http://www.xmpp.org/extensions/xep-0124.html) bridges the Web to the XMPP protocol and works via [long polling](http://en.wikipedia.org/wiki/Long_polling#Long_polling).  Most of the [XMLHttpRequests](http://en.wikipedia.org/wiki/Xmlhttprequest) contain short XMPP stanzas like the one below (whitespace and formatting added for clarity).

<code>
<pre name='code' class='xml'>
&lt;body rid='1944468766' 
         xmlns='http://jabber.org/protocol/httpbind' 
         sid='650f4bda7d67c85a8b9ae1378742b370'&gt;
  &lt;iq id='3318:getroominfo' to='centralpark@chat.chesspark.com' type='get'&gt;
    &lt;query xmlns='http://jabber.org/protocol/disco#info'/&gt;
  &lt;/iq&gt;
&lt;/body&gt;
</pre>
</code>

That's 245 bytes of data.  Here are the request headers sent during this request.

<code>
<pre>
Host: www.chesspark.com
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.3) Gecko/2008092414 Firefox/3.0.3
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-us,en;q=0.5
Accept-Encoding: gzip,deflate
Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
Keep-Alive: 300
Connection: keep-alive
Referer: http://www.chesspark.com/play/?nologin
Content-Length: 245
Content-Type: application/xml; charset=UTF-8
Cookie: sessionid=a7ad697adaf3b501b74b9aa5d215ce7a; __utma=57803256.2324767445786134500.1226380646.1226380646.1226380646.1; __utmb=57803256.2.10.1226380646; __utmc=57803256; __utmz=57803256.1226380646.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)
Pragma: no-cache
Cache-Control: no-cache
</pre>
</code>

That's 759 bytes, or over 3 times the amount of actual data.  It's far worse when a blank request is sent, which with BOSH is quite often.  A large chunk of this is the cookie, which unfortunately cannot be eliminated without using a separate domain.  In this particular case that would mean that user friendly features like auto-login would not work.

This wouldn't be nearly so bad if there were programmatic access to turn on and off these headers from JavaScript.  Such access does not exist, and I've seen no indication that this feature is on the horizon.  Almost all of these headers are useless for BOSH or even AJAX.

I hope the browser vendors optimize these headers in the case of XMLHttpRequest or at least allow developers to control them.  As it stands, these headers make up the bulk of BOSH related traffic and end up preventing the user from getting the fastest and lowest latency connection that is possible.
