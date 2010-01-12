---
layout: post
title: Trying to Use Strophe with Prototype, Dojo, and YUI
tags: [xmpp, jabber, javascript, strophe, code, yui, dojo, prototype, jquery]
time: "23:18"
extended: ":EXTENDED:"
---

I use [jQuery](http://jquery.com) quite a bit in my own JavaScript
development, and I think it [works quite well with
Strophe.js](http://metajack.im/2009/03/13/jquery-and-strophe-made-for-each-other/). However,
not everyone uses jQuery, so I want to write a series of tutorials
on how to use the other popular JavaScript libraries with
Strophe. Unfortunately, I am running into issues with stanza
manipulation, and I need your help.

My goal is to show the three or four most common pieces of each
library that make writing XMPP applications easier. In my own code,
and in the applications in [Professional XMPP
Programming](http://professionalxmpp.com), I use features like DOM
manipulation to work with XMPP stanzas and custom events to make
separating code easier.

In jQuery, these normally take the form of `$(document).bind()` and
`$(document).trigger()` for events and `$(stanza).find()` or
`$(stanza).children()` for stanza manipulation. It turns out to be
pretty easy stuff.

Unfortunately, I can't seem to get stanza manipulation working in any
other library. Below are the problems I've run into, and I'm hoping
that someone more familiar with these libraries can offer some
assistance.

## YUI

The more I read about YUI, the more I like it. It seems quite well
designed, and I'm seriously considering using it in some real
projects. However, it doesn't seem to be able to deal with XMPP
stanzas at all.

You can convert an XMPP stanza, which is an XML DOM element, to a YUI
Node object with `Y.one(stanza)`. This works great, and you can easily
access attributes with functions like
`Y.one(stanza).getAttribute('from')` or
`Y.one(stanza).get('tagName')`. Unfortunately, finding arbitrary child
elements doesn't work. `Y.one(stanza).all('item')` returns an empty
NodeList object, even when the stanza has several `&lt;item>`
children.

Similarly, using `Y.Selector.query()` also fails to find the elements.

Both of these functions work great on the HTML DOM elements I've
tried, so I suspect this is an issue with XML DOM elements.

## Dojo

I've been meaning to check out [Dojo](http://dojotoolkit.org) for
quite a while, and I was pretty excited to put it to use on
XMPP. After all, it has some [XMPP
support](http://api.dojotoolkit.org/jsdoc/1.3/dojox.xmpp) built in. It
also has an implementation of
[Twisted](http://twistedmatrix.com)-style
[deferreds](http://api.dojotoolkit.org/jsdoc/1.2/dojo.Deferred) which
make asynchronous programming awesome.

Unfortunately, Dojo also seems unable to work with XMPP
stanzas. `dojo.query('item', stanza)` returns an empty array.

## Prototype

I've used [Prototype](http://prototypejs.org) on projects in the past
and was quite happy with it. I figured this task would be a piece of
cake since it's one of the older libraries.

Just like YUI and Dojo, though, it can't seem to manipulate XMPP
stanzas. `stanza.select()` doesn't work because Prototype doesn't seem
to extend XML DOM element objects. `Selector.findChildElements(stanza,
['item'])` fails with `$(root).identify is not a function`, which I
assume is also an XML DOM problem.

If you can help figure out how to use these libraries to access and
manipulate XMPP stanzas, or just let me know if it's really not
possible, it would be much appreciated.
