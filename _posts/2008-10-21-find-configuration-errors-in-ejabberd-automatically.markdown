---
layout: post
title: Find Configuration Errors In Ejabberd Automatically
tags: [ejabberd, jabber, xmpp]
time: "20:41"
extended: ":EXTENDED:"
---

Sometimes ejabberd doesn't start up and you are left wondering what's wrong.  This could be because the configuration file `ejabberd.cfg` has an error in it.  You can easily avoid this situation by doing a check check that the file is valid before starting or restarting ejabberd.  This caused some confusion on [jabber.org](http://www.jabber.org/) a while back, and we now regularly check the syntax of `ejabberd.cfg` whenever something isn't working right.



:EXTENDED:

## The Error

Ejabberd can be mysterious sometimes, but no program is perfect.  The reason this particular error is so frustrating is that it never appears in `ejabberd.log`.  For some reason I've yet to suss out, configuration file parsing errors appear in `sasl.log` (ejabberd bug [EJAB-777](https://support.process-one.net/browse/EJAB-777)).  Here's a truncated example.

    =CRASH REPORT==== 21-Oct-2008::20:14:19 ===
      crasher:
        pid: <0.35.0>
        registered_name: []
        exception exit: {bad_return,
                            {{ejabberd_app,start,[normal,[]]},
                             {'EXIT',
                                 "/Users/jack/ejabberd/etc/ejabberd/ejabberd.cfg approximately in the line 493: syntax error before: '.'"}}}

## Quick Solution

The solution I tend to use is just to run `ejabberd.cfg` through the [Erlang](http://www.erlang.org) interpreter.

    $ cat ejabberd.cfg | erl | grep syntax

If that command returns a syntax error line, you know there is a problem in the config file.  If there is no output, ejabberd.cfg parses correctly.

## Other Solutions

A bug for this issue already exists as ejaberd bug [EJAB-51](https://support.process-one.net/browse/EJAB-51).

Magnus Henoch also wrote an [ejabberd config file checker](http://www.dtek.chalmers.se/~henoch/ejabberd-xml/), but it takes a little more effort than my solution above.  However, his solution would be what the ejabberd team would need for an internal solution I suspect.

I hope this helps some of you having issues with your ejabberd installations, and hopefully the ejabberd developer team can fix this little bugs so that using ejabberd is even easier.
