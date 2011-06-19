---
layout: post
title: Strophe.js 1.0.2 Released
tags: [strophe, xmpp, javascript, code]
time: "10:26"
extended: ":EXTENDED:"
---

I've just tagged and released Strophe.js 1.0.2. You can find it on the
[new Strophe.js site](http://strophe.im/strophejs).

Please consider upgrading as soon as possible, as a security problem
was found in Strophe.js 1.0.1. The DIGEST-MD5 SASL method used a
constant client nonce due to a bug in Strophe's use of the underlying
MD5 library. I don't know of any exploits for this bug, but it could
compromise your site's security.

Much of the credit for this release goes to the many contributions and
pull requests that people have sent in the last year. The community's
effort continues to make Strophe.js better and better.
