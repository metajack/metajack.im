---
layout: post
title: Speed Up Ejabberd
tags: [xmpp, jabber, ejabberd, xml]
time: "23:28"
extended: ":EXTENDED:"
---

Whenever an XMPP server or client writes stanzas to the wire, it must
serialize its internal XML representation to real XML.  This
serialization process is the biggest consumer of clock cycles in XMPP
code.  Ejabberd is no exception, but you can make serialization almost
ten times faster with this little trick.

[Erlang](http://www.erlang.org) comes with a native code compiler
called HiPE (High Performance Erlang).  One of the great things about
Erlang is that you can mix native modules and byte-compiled modules
freely.  We're going to native compile the ejabberd XML routines to
achieve the speed boost.

First, you'll need some ejabberd source code.  The file we want to
compile is `ejabberd/src/xml.erl`.  If you installed ejabberd from a
package, don't worry.  You don't even need to run configure.

Next, go to the directory with `xml.erl` and run the compiler:

    cd ejabberd/src
    erlc +native xml.erl

Finally, move the `xml.beam` file into your `ebin` directory.  On
Ubuntu, this is normally `/usr/lib/ejabberd/ebin`, but it might also
be under `/usr/local/ejabberd/ebin`.  Just replace the `xml.beam` that
is already there.

That's it!  Now you're XML routines will execute much faster!  It
would be great if the ejabberd team made this the default for CPU
hungry modules.
