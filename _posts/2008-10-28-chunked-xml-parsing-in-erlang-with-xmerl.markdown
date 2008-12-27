---
layout: post
title: Chunked XML Parsing In Erlang With Xmerl
tags: [code, ejabberd, erlang, erlsom, jabber, xmerl, xml, xmpp]
time: "21:20"
extended: ":EXTENDED:"
---

Most XML libraries parse entire documents or complete XML snippets contained in strings.  Many can be used to parse data in arbitrary chunks, and this is useful in a number of applications.  [XMPP](http://www.xmpp.org) requires chunked parsing, since whenever you get some data, you have no idea whether it is a complete stanza or some small fragment.  I've been playing with [Erlang](http://www.erlang.org) quite a bit lately, and since several people have asked about this, I figured I'd post a small example of how to do this with [xmerl](http://erlang.org/doc/apps/xmerl/part_frame.html).

The following module uses `xmerl_scan:string/2` to parse a string with partial XML data.  It passes the option `continuation_fun` to the function which it will call if it needs more data to complete the parse.  The continuation function gets a function to call when it has more data or if it cannot get more data; these are the `Continue` and `Exception` variables, which are functions.  For this example, we just send it the rest of our contrived data, but in a real example this might put the `Continue` and `Exception` functions into the server state and call them when the underlying socket receives more data.

    -module(xmltest).
    
    -export([main/0, continue/3]).
    
    continue(Continue, _Exception, GlobalState) ->
        Data = "test</beep>",
        Continue(Data, GlobalState).
    
    main() ->
        xmerl_scan:string("<beep>", [{continuation_fun, fun continue/3}]).

That's all there is to it.

As a side note, [ejabberd](http://www.ejabberd.im) uses an [expat](http://expat.sourceforge.net/) based custom parser.  I think they do this because xmerl used to be slow, but I'm actually not sure of the exact reason.  There is also another XML parser for Erlang called [erlsom](http://erlsom.sourceforge.net/); the main difference seems to be that it can parse binaries directly instead of just strings.  Perhaps if I get bored I will do some timings between the three parsers for the chunked parsing case.

:EXTENDED:


