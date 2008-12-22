---
layout: post
title: SRV Lookups In Erlang
tags: [code, erlang, srv]
time: "20:44"
extended: ":EXTENDED:"
---

I'm working on a new bit of code in [Erlang](http://www.erlang.org) that needs to do [SRV](http://www.faqs.org/rfcs/rfc2782.html) lookups.  I figured since Erlang is famous for being great at building servers that it would have built in facilities for querying DNS in all kinds of ways.  Imagine my surprise when I discovered that the only documented ability it has for DNS is the really simple `inet:gethostbyname`.  Digging around in the Erlang/OTP source code and through [ejabberd](http://www.ejabberd.im) I was able to piece together the needed pieces to make an SRV module.



:EXTENDED:

## What Happened To The Documentation?

A lot of Erlang is very well documented.  There is a [book](http://pragprog.com/titles/jaerlang/programming-erlang), a [design guide](http://www.erlang.org/doc/design_principles/part_frame.html), and a bunch of well written [man pages](http://www.erlang.org/doc/man/).  Unfortunately the documentation stops abruptly at the `inet` module, even though there are lots of sub modules that contain very useful functions.

`inet_res:getbyname/2` is what is needed to do SRV lookups.  It's not clear to me why all these different `inet` sub-modules do.  For example, there are `inet_db`, `inet_res`, and `inet_config` modules.  DNS lookup routines are spread over all of these, and often they have the same names.  I've seen mention on the [mailing lists](http://www.erlang.org/mailman/listinfo) that parts of these might be deprecated, but I don't really understand why when they seem to contain useful functions that don't exist elsewhere.

## Resolver Configs And More Missing Documentation

One issue you might run into trying to use `inet_res` is that it always returns `{error, timeout}`.  It turns out that through some idiosyncrasy of the virtual machine startup, the configuration for the resolver only gets set up if the virtual machine is used with the `-name` parameter.  Without `-name` and even with `-sname`, the resolver just doesn't get set up.

Digging through ejabberd's source code, I found the `inetrc` file, and this is pointed to by the `ERL_INETRC` environment variable which exists in all the ejabberd scripts.  It turns out this is yet another undocumented Erlang bit.  If `ERL_INETRC` is defined and points to a valid `inetrc` file, all the DNS resolver functions will magically work, even without the `-name` parameter.

Oddly, `inet:gethostbyname` always works, even without special configuration or parameters.  Too bad it can't do SRV lookups.

## The Result

The SRV lookup module I created is available [here](http://metajack.im/code/srv.erl).  I'll go over the code and how to use it in my next post.  It's nothing earth-shattering, but if any of you are budding Erlang programmers, you might find it helpful.
