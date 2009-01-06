---
layout: post
title: Brevity And Programming Languages
tags: [code, lisp, erlang, python, perl, haskell, emacs, emacs lisp]
time: "22:03"
extended: ":EXTENDED:"
---

Once upon a time I was an avid Perl hacker, but at some point I got
fed up with it and switched over to Python.  I've spent a lot of time
with Python, and it's my standard choice for writing new code unless
another tool offers a big advantage to the problem at hand.  Lately
I've been doing quite a bit of hacking in Erlang and playing a bit
with Lisp.  One thing is for sure, I sure miss the brevity of Python.

I think Perl is too terse; all the symbols so close together start to
impact readability.  Erlang and Lisp both seem quite verbose.  Perhaps
this is a direct result of both languages lack of namespaces.

# Namespaces

In Erlang, code lives in a module, but there are no sub-modules.
Sub-modules end up getting named like 'module\_foo' and
'module\_bar'.  This makes for pretty long lines when you need to
string together several operations from different modules.

In Lisp (or at least in Emacs Lisp which is the dialect I've been
working in) there aren't any namespaces at all, which makes it quite
similar to Erlang, just with no special symbols.

In Python, I can just import the sub-modules directly, and get rid of
lots of namespace, resulting in a lot less typing and no real loss of
clarity.

# Data Structures

The other main factor contributing to code brevity is good support for
data structures.  Lisp and Erlang have excellent support for lists,
but they are more clumsy with hash tables.  `(make-hash-table)` (or
even `(makehash)`) is a lot more work than `{}`.  `dict:fetch(Key,
Dict)` is a lot more than `dict[key]`.

Python, Ruby, Perl, and many other languages have first class support
for these data structures and that goes a lot way to making the
shorter and easier to write.  They feel bolted on in Erlang and Lisp.

# Worth the Trade-offs

Even though they are more verbose, Lisp and Erlang are worth the
trade-offs in many cases.  Nothing else has a concurrency model like
Erlang, and the power of code-as-data is immense.

If you're an Erlang or Lisp hacker, I'd love to hear your thoughts on
these issues.  I'm still a newcomer in these lands and have much to
learn.

This year I think I will [learn me a Haskell for great
good](http://learnyouahaskell.com).  I've heard a lot of great things
about it, but have yet to dive in.
