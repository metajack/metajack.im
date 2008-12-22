---
layout: post
title: TLS Issues With Google Talk
tags: [google, google talk, jabber, tls, xmpp]
time: "16:15"
extended: ":EXTENDED:"
---

It appears as though something broke with [Google Talk's](http://talk.google.com) servers recently.  [Reports](http://twistedmatrix.com/trac/ticket/3463) are coming in of sudden TLS negotiation failures.  Fabio [claims](https://mailman.ik.nu/pipermail/twisted-jabber/2008-November/000179.html) that older versions of [OpenSSL](http://openssl.org/) are at fault, but [Ralph](http://ralphm.net) suspects that [something changed](https://mailman.ik.nu/pipermail/twisted-jabber/2008-November/000178.html) at Google.

Specifically this means [Twisted Python](http://www.twistedmatrix.com) and [Wokkel](http://wokkel.ik.nu) code won't work with Google Talk (hosted or otherwise).  I'm sure other clients are affected as well, but I haven't seen many other reports of this.  There are work arounds, but they are not very good ones, and certainly will not be accepted solutions upstream.  The main one is to switch to SSL v2 or v3, although Fabio reports that using the latest releases of OpenSSL instead of the distribution supplied ones also appears to work.

Both Ralph and I have been attempting to reach our contacts on the Google Talk team.  Please leave a comment if you have any more information.

:EXTENDED:


