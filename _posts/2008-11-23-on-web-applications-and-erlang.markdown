---
layout: post
title: On Web Applications And Erlang
tags: [code, erlang, web]
time: "19:01"
extended: ":EXTENDED:"
---

There is certainly a [lot](http://yarivsblog.com/articles/2006/10/27/introducing-erlyweb-the-erlang-twist-on-web-framworks/) [to](http://nitrogen-erlang.tumblr.com/) [choose](http://code.google.com/p/mochiweb/) [from](http://yaws.hyber.org/) in the [Erlang](http://www.erlang.org) Web framework space, but that is not what I want to talk about.  For those of you not familiar with Erlang, it is a pure [message passing](http://en.wikipedia.org/wiki/Message_passing) system.  There are lots of tiny, cheap processes, and they communicate by passing messages as opposed to sharing memory and state.  If you think about this a little, you realize that this is a lot like programming for the Web.

For all the talk about how weird Erlang is, it seems to me that at its core, the Erlang model is quite familiar to most modern programmers.  Replace the `!` operator and commands like `sync_send_event` or `call` with HTTP GET, PUT, and POST.  Erlang's terms are also essentially binary JSON.  Instead of processes the Web has millions of servers and clients talking to each other.

Couple this with the fact that most people doing JavaScript these days are getting intimately familiar with [functional](http://en.wikipedia.org/wiki/Functional_programming) concepts like [closures](http://en.wikipedia.org/wiki/Closure_(computer_science\)), and the distance between Erlang programming and Web programming turns out to be quite short.

I think if people would look beyond the syntax (after all, beauty is only skin deep), Web programmers would be flocking to Erlang in greater numbers.

:EXTENDED:


