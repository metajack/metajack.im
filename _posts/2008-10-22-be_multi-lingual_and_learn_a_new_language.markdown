---
layout: post
title: "Be Multi-Lingual And Learn A New Language"
tags: [books, code, haskell, javascript, languages, python, ruby, scheme]
time: "16:17"
extended: ":EXTENDED:"
---

How many programming languages do you know?  Hopefully the answer is more than one or two.  How many languages have you learned this year?  Knowing multiple programming languages is a practical skill for several reasons.  Each language brings its own specialities which can broaden your toolset.  It can also make you more proficient in your preferred language by demonstrating other possibilities.  I'm a believer in learning multiple languages and also in using the right tool for the job.



:EXTENDED:

## Multi-Lingual Inspirations

Languages have been borrowing and building on each others features for decades.  Just look at the functional parts of [Python](http://www.python.org) or [Ruby](http://www.ruby-lang.org) as an example of this.  Is it coincidence than [Haskell](http://www.haskell.org) and [Erlang](http://www.erlang.org) share almost identical syntax for list comprehensions?  The borrowing doesn't stop there.  Many developers have been inspired by features from one language or a language's well known toolkit and re-implemented them elsewhere.  Here are some examples of that.

[Twisted](http://www.twistedmatrix.com) is one of the most well known Python libraries, right up there with [Zope](http://www.zope.org) and [Django](http://www.djangoproject.com).  One of Twisted's best features is [deferreds](http://twistedmatrix.com/projects/core/documentation/howto/defer.html).  These have been re-implemented in [JavaScript via MochiKit](http://mochikit.com/doc/html/MochiKit/Async.html) and now in [C++](http://twistedmatrix.com/pipermail/twisted-python/2008-October/018548.html).

An example from my own work is [Strophe](http://code.stanziq.com/strophe).  The JavaScript code in Strophe is inspired by [bound methods](http://coding.derkeiler.com/Archive/Python/comp.lang.python/2003-11/4203.html), which JavaScript does not have.  In a large application like [Chesspark](http://www.chesspark.com), state is kept in various objects, and so it is important to have Strophe use bound method callbacks.  The original version of Strophe implemented this by passing the instance objects along with string method names;  the current version uses `Function.bind()` to create a bound method via a closure.

In both of these cases, the solutions might never have been encountered had we not experimented with many languages.

## Some Suggested Reading

Learning a new language doesn't have to be arduous or boring.  Here are some books that make it extremely fun.

* [The Little Schemer](http://www.ccs.neu.edu/home/matthias/BTLS/) - You can learn [Scheme](http://schemers.org/) without needing a computer with this fun book.  There are at least two sequels as well.  It also serves as an interesting introduction to programming in general.
* [Why's (Poignant) Guide To Ruby](http://poignantguide.net/ruby/) - This free, online book is hilarious and illustrated with cartoons.  Even if you care nothing for Ruby, this book is worth a read just for its entertainment value.
* [Learn You A Haskell For Great Good!](http://learnyouahaskell.com) - This Haskell primer is also online, free, and entertaining.  While not quite as funny or well illustrated as Why's book, it is clearly in the same spirit.
* [Dive Into Python](http://diveintopython.org) - This Python book is quite good.  It has numerous examples, including the hilarious [Kant Generator](http://diveintopython.org/xml_processing/) in the chapter on XML processing.

There are excellent books for many programming languages, but these are ones I have enjoyed over the past few years.  If you know of other good ones I'd love to hear about them!  Perhaps I'll have time to learn and play with another new language before the year is up.
