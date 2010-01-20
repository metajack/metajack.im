---
layout: post
title: Cross-Domain AJAX for XMPP HTTP Binding Made Easy
tags: [xmpp, jabber, crossdomain, ajax, bosh, ejabberd, punjab]
time: "23:52"
extended: ":EXTENDED:"
---

[Fabio Forno](http://blog.bluendo.com/ff) recently asked me to help
him debug a weird issue with browsers sending OPTIONS requests when
using [Strophe.js](http://code.stanziq.com/strophe). After digging in
a little, I realized that this was the browser checking for
authorization to do cross-domain AJAX requests according to the
[W3C](http://www.w3.org)'s [Cross-Origin Resource
Sharing (CORS)](http://www.w3.org/TR/cors/) recommendation. If you've
never heard of CORS before (I hadn't), it is how modern browsers
request and receive authorization for doing cross-domain HTTP
requests. In other words, it makes modern browsers able to do
cross-domain requests without Flash, without proxies, and without
other crazy hacks.

:EXTENDED:

I went about testing this support in the browsers and found that
Firefox 3.5 and up, Safari, and Chrome all support CORS. IE, of
course, does not support this, but it looks like IE8 has a secondary
XMLHttpRequest object that does support CORS. I'll have to investigate further.

Furthermore, since CORS is simply information communicated via HTTP
headers, no changes are necessary to any code except to existing BOSH
connection managers. The implementation is so trivial, I was able to
quickly develop patches for both [ejabberd](http://www.ejabberd.im)
(patch in [bug EJAB-1168](https://support.process-one.net/browse/EJAB-1168))
and [Punjab](http://code.stanziq.com/punjab) (patch in [bug
\#26](http://code.stanziq.com/punjab/ticket/26)).

The BOSH connection manager I run as a testing service at
[http://bosh.metajack.im:5280/xmpp-httpbind](http://bosh.metajack.im:5280/xmpp-httpbind)
is already running the new CORS-enabled code.

## Using CORS from Strophe

Using CORS from Strophe is extremely simple. Just set your BOSH
service URL to the full domain, port, and path of the BOSH connection
manager. For example,
`http://bosh.metajack.im:5280/xmpp-httpbind`. Firefox, Safari, and
Chrome will be able to do cross-domain requests without any issues
since the connection manager will return the right CORS headers to
allow the requests.

I still need to add some detection for this support and fallback to
something else when it is not found, but I think it is already
extremely useful. For example, XMPP web application development for the
iPhone is now extremely easy.

## How CORS Works

CORS works very similarly to Flash's
[crossdomain.xml](http://www.adobe.com/devnet/articles/crossdomain_policy_file_spec.html)
file. Basically, the browser will send a cross-domain request to a
service, setting the HTTP header `Origin` to the requesting
server. The service includes a few headers like
`Access-Control-Allow-Origin` to indicate whether such a request is
allowed.

For the BOSH connection managers, it is enough to specify that all
origins are allowed, by setting the value of
`Access-Control-Allow-Origin` to `*`. The `Content-Type` header must
also be white-listed in the `Access-Control-Allow-Headers` header.

Finally, for certain types of requests, including BOSH connection
manager requests, the permissions check will be pre-flighted. The
browser will do an OPTIONS request and expect to get back some HTTP
headers that indicate which origins are allowed, which methods are
allowed, and how long this authorization will last. For example, here
is what the Punjab and ejabberd patches I did return for OPTIONS:

<pre>
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, POST, OPTIONS
Access-Control-Allow-Headers: Content-Type
Access-Control-Max-Age: 86400
</pre>

You can learn more about CORS either at the excellent [HTTP Access
Control](https://developer.mozilla.org/en/HTTP_access_control) article
at [developer.mozilla.org](http://developer.mozilla.org) or by reading
the [CORS recommendation](http://www.w3.org/TR/cors/).

I hope to convince all the major BOSH implementations to support this
as well. Hopefully within a short period, we can eliminate the need
for annoying proxies, Flash, or browser hacks.
