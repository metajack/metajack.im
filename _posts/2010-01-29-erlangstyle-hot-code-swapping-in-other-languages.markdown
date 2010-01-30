---
layout: post
title: Erlang-style Hot Code Swapping in Other Languages
tags: [python, code, erlang]
time: "23:50"
extended: ":EXTENDED:"
---

One of my favorite features of Erlang, and one that is pretty unique,
is the ability for the runtime to host two versions of the same
code. This allows for hot code swapping. New clients of the code use
the new version, while old clients continue to use the old version
until they are finished. It's really quite awesome.

This is of course possible in other languages, but it takes quite a
lot of manual effort. I ran across [this
post](http://www.codexon.com/posts/hot-code-swapping-for-servers-not-written-in-erlang)
about doing hot code swapping with Python.

These are the kind of features that you can take for granted in
Erlang. They tend to be possible, but tedious, in other languages,
which unfortunately means they are not often used.

