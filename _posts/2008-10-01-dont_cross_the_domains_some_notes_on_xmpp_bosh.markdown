---
layout: post
title: "Don't Cross The Domains: Some Notes On XMPP BOSH"
tags: [bosh, http, jabber, javascript, xmpp]
time: "20:00"
extended: ":EXTENDED:"
---

One of the first questions I get asked about [Strophe](http://code.stanziq.com/strophe) and [Punjab](http://code.stanziq.com/punjab) is whether they can work cross domain.  JavaScript implementations prevent outgoing connections except to the server of the page running the code.  This means that any AJAX request must be made to the server which served the page; it cannot cross the domain.  There are published loopholes for making cross domain requests, but these amount to hacks which may stop working in the next version of the browser.  In most cases, XMPP BOSH does not need these hacks to work, even if you want to connect to arbitrary XMPP servers.

:EXTENDED:

## A BOSH Interface Is Just A URL

BOSH provides a single entry point - a URL.  Client code makes requests of this URL and processes the responses.  All XMPP data is shuttled through this URL to and from the underlying BOSH connection manager, and eventually to an XMPP server.

Once data is has arrived at the connection manager, the security policy of the browser is no longer in effect.  If the BOSH server is of the stand-alone type (see [Which BOSH Server Do You Need?](http://metajack.im/2008/09/08/which-bosh-server-do-you-need/)), it can connect to any public XMPP server it likes.  This means that the only requirement for JavaScript code to talk to any XMPP server is to have a BOSH URL at the origin Web site.

Doesn't this mean you must run a BOSH connection manager on your Web server?  Definitely not.  Manipulating URLs is what Web servers are built for.  Any decent Web server will support proxying the content of an arbitrary URL to a local URL.  This means you can run a BOSH server anywhere on the Internet, and proxy the requests from a local URL to the BOSH endpoint.

## Proxied BOSH Is The Best Kind Of BOSH

Web proxying is quite powerful.  Proxied BOSH services can make use of a lot of proxy magic that has been implemented by clever Web server hackers.  Here are some things you can do by proxying BOSH:

* **Load balancing**.  Some Web servers will send requests to a proxied URL to a pool of servers instead of to a single server.  At [Chesspark](http://www.chesspark.com) we use this to power our [BOSH cloud](http://thetofu.livejournal.com/71339.html).
* **Fail over**.  Since the URL is proxied, it is easy to fail over BOSH services if the BOSH service being proxied dies.  All you have to do is proxy a different BOSH service.  Really cool Web servers will allow you to combine this with load balancing and support automated fail over.
* **Geographic distribution**.  If you want faster BOSH service for European users, proxy a BOSH server in Belgium for them while keeping US users proxied to a service in New York.  IP geo-location services can be used to make the decision on the fly.
* **Shared BOSH**.  BOSH services can easily be shared among many Web sites just by proxying the same BOSH URL at every site.  We use this extensively to give our development and production systems access to the same BOSH cloud.

## When Do You Need Cross Domain JavaScript For BOSH?

There may be some use cases where cross domain BOSH is really required, but I cannot easily think of one.  If you know of such a use case, please leave a comment.  

If cross domain BOSH is needed, there are those hacks I mentioned above.  People have already tried things like abusing the &lt;script&gt; tag to make BOSH requests, but most of them tend to place restrictions on the BOSH service that aren't normally there.  From my brief survey of various methods, [window.name transporting](http://www.sitepen.com/blog/2008/07/22/windowname-transport/) seems the most capable.

## Don't Wait For The Future

Cross domain issues may be resolved by future versions of Web standards, but these proposed standards are currently being [hotly debated](http://ajaxian.com/archives/the-fight-for-cross-domain-xmlhttprequest).  Even if new standards do emerge, it will likely be years before they are widely implemented.

Fortunately, the present solutions, which leverage Web technology instead of working against it, are workable and provide a lot of value.  So put your Web server to work proxying BOSH service to your application and enjoy the future of the Web today.
