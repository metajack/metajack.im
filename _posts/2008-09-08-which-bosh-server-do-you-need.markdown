---
layout: post
title: Which BOSH Server Do You Need?
tags: [bosh, ejabberd, jabber, punjab, tigase, xmpp]
time: "11:28"
extended: ":EXTENDED:"
---

If you've decided you use [BOSH](http://www.xmpp.org/tech/bosh.shtml) for an XMPP enabled Web service or to allow Web based XMPP clients to connect to your server, you'll find that you have a couple of choices.  For starters, there are two kinds of BOSH connection managers - built in and stand-alone. What are the advantages of the built in ones, and when should you use a stand-alone connection manager?

:EXTENDED:

## Built In BOSH

Several severs now come with built in BOSH support: [ejabberd](http://www.ejabberd.im), [Tigase](http://www.tigase.org), [Openfire](http://www.igniterealtime.org/projects/openfire/index.jsp), and [Jabber XCP](http://www.jabber.com).  These can be enabled in the server configuration and allow BOSH clients to make connections.

Built in BOSH support has several advantages.  

* It's well tested against your server, since the server vendor or its community have written both parts.  This saves you from any compatibility worries.
* It should be more efficient.  Built in BOSH can speak natively to the server using its internal routing protocols or direct API calls.  This means there is little to no overhead for the connection manager other than maintaining the BOSH state.
* It's very easy to set up.  Since it is built in, the only work needed is to uncomment or add a few configuration lines.

This is not the whole story, however.  Built in BOSH has significant drawbacks.

* It can only make connections to the server it runs on.  At least for now, the build in BOSH support only allows local server connections, which means that you can't use it for powering federated Web applications.  If you don't need to allow connections to other servers, then this is not a big deal; if you do, this is a deal-breaker.
* Scaling may be harder.  Since built in BOSH is tightly coupled with the server, how easily it scales is a function of how easy the developer has made it.  Not only will you have to deal with the Internet facing side of proxies and load balancers, but you will also have to configure the server to support multiple BOSH connection managers if that is allowed.
* Support depends on the server development community.  Not all XMPP servers come with built in BOSH.   For example, neither [jabberd](http://jabberd.org) or [jabberd2](http://jabberd2.xiaoka.com) have BOSH support.

If you don't need to support other XMPP servers, and your XMPP server supports built in BOSH, then your BOSH connection manager choice is easy.

## Stand-alone BOSH

There are a few implementations of BOSH that are not tied to a particular XMPP server implementation: [Punjab](http://punjab.sourceforge.net/), [Araneo](http://blog.bluendo.com/ff/bosh-connection-manager-update), [JabberHTTPBind](http://blog.jwchat.org/jhb/), and [rhb](http://rubyforge.org/projects/rhb/).  Punjab was originally written by [my co-worker](http://thetofu.com), and it is the server I am most familiar with since we use it heavily at [Chesspark](http://www.chesspark.com).  

The advantages and disadvantages of stand-alone BOSH connection managers are the same as those above only inverted.  

Stand-alone connection managers can make connections to any XMPP server.  This means a Web application that is XMPP powered can offer the service to the entire federated network, and it doesn't even have to run an XMPP server of its own.  This server independence comes at the price of overhead.  Each client BOSH connections requires a connection to that user's server.  Each BOSH connection usually has two persistent HTTP connections plus a persistent TCP connection to the XMPP server. This is very similar to a proxy server setup.

The other advantage of stand-alone connection managers is their simplicity.  Since they have not server-specific logic, they all behave the same way, and this makes scaling them fairly easy.  One trick is to run several BOSH servers behind a load balancing proxy like [nginx](http://nginx.net).  Tofu has written about this in his blog about the [Chesspark BOSH Cloud](http://thetofu.livejournal.com/71339.html).

Federated XMPP Web applications need exactly these two advantages.  If you're doing more than just allowing new clients to connect to your existing XMPP server, you probably want a stand-alone connection manager.

## What To Do With BOSH

Once you have a BOSH enabled server or a stand-alone BOSH connection manager, you'll soon discover that [XMPP is better with BOSH](http://metajack.im/2008/07/02/xmpp-is-better-with-bosh/).  What you do from here is limited only by your creativity.  You could create [real-time Web games](http://www.chesspark.com), microblogging clients, monitoring applications, or just add chat support to your Web site.  The future of the Web is XMPP, and BOSH will help you get there.
