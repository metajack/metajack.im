---
layout: post
title: Thoughts On Concurrent Programming
tags: [clojure, code, erlang, python]
time: "22:57"
extended: ":EXTENDED:"
---

I'm a fan of [learning lots of languages](http://metajack.im/2008/10/22/be-multi-lingual-and-learn-a-new-language/), and there are plenty of interesting ones out there to learn.  I was recently watching some of the [Clojure](http://clojure.org/) [videos](http://clojure.blip.tv), and Rich Hickey had a nice quote about concurrent programming:

> Mutable objects are the new spaghetti code.

Having written more than my fair share of multi-threaded applications, I completely agree.  Shared nothing concurrency is the way to go.



:EXTENDED:

My tool of choice is currently [Erlang](http://www.erlang.org), as you can probably tell if you've been reading this blog recently.  We can also see [Python](http://www.python.org) approaching this model with their [multiprocessing module](http://www.python.org/doc/current/library/multiprocessing.html).  The [Twisted](http://www.twistedmatrix.com) mailing list often has threads on message passing concurrency in Python as well.  Even Guido [thinks](http://moderator.appspot.com/#15/e=c9&t=ff&q=2f40&v=4) this is the way to go:

> My expectation is that something not entirely unlike the Actor paradigm, but implemented on top of the multiprocessing package, will eventually become the recommended best practice for reaping the benefits of multiple cores.

Of course, the wonderful thing about Erlang is that it takes the multiprocessing module style concept to the next level with extremely lightweight, cheap processes.  You can create a tens of thousands of Erlang processing in a few milliseconds.  It also already contains distribution primitives so that processes can be created on any machine; this is something that Clojure and Python still lack.  The price you pay for distribution is in slightly more complex failure handling, but Erlang's OTP behaviors make these pretty easy to deal with.

I imagine that we will see many languages start picking up these pieces and playing around with them as more and more people realize that shared state and mutable objects are a difficult path forward.
