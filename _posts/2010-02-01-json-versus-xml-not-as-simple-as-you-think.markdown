---
layout: post
title: "JSON versus XML: Not as Simple as You Think"
tags: [json, xml, xmpp, bosh]
time: "22:27"
extended: ":EXTENDED:"
---

There has always been a fair amount of backlash against XML, but this
has really heated up since JSON became popular. A lot of people want
to throw XML out the window and use JSON for everything, and for many
problems, this is a reasonable thing to do. JSON and XML have many
similar properties, but XML has some tricks up its sleeve that JSON
can't yet match.

:EXTENDED:

## JSON's Charms

One of the main charms of JSON is its terse syntax. XML elements must
have names, and much of the time, elements need corresponding open and
closing tags. JSON's syntax, however, is almost negligible in most
cases.

JSON data also maps extremely cleanly onto the objects of most
object-oriented languages. This is no real surprise since JSON is the
literal representation of an object (or array or scalar) in a
particular OOP language. Even when using JSON from a language like
Python or Lua, the mapping remains nearly exact and immensely
familiar.

## Where XML is Better

XML has a more complex structure than JSON, and this is both a
weakness and an asset.

The more complex structure doesn't neatly map onto traditional OOP
language objects. For example, multiple elements with the same name
may exist at the same level in XML, but most (if not all) languages
only allow unique property names. This discrepancy gave birth the DOM
API, which I don't think anyone loves.

However, this more complex structure has one property that I think is
more than redeeming; XML can be trivially extended.

In XML, you can add a child element or an attribute to anything you
want. XML namespaces can be used to prevent clashes. Software that
encounters these extended attributes and elements doesn't break; it
can simply ignore them. Much of the power of the XMPP protocol comes
from this property of XML.

In JSON however, extension is not so easy. How do I extend a given
JSON object with new data? I can add a new property (assuming it
doesn't clash with a current or future one), but extending a given
property is harder. If JSON property value is a number, how do I add
more information?

You can certainly choose to make every property value an object, so
that new properties can be added anywhere, but as soon as you do this,
most of the simplicity of JSON is gone.

For example, the [Collecta API](http://developer.collecta.com) does
something very similar so that it can represent arbitrary Atom with
extensions; it turns out this makes the JSON data cumbersome to work
with, and we've received nothing but complaints from users about
it. We're working on a simplified, more JSON-ic, API, but the penalty
will be that it won't be able to represent all the data.

I get asked a lot why [XMPP BOSH](http://xmpp.org/tech/bosh.shtml)
doesn't use JSON instead of XMPP, and the answer is similar. You lose
a lot of the extensibility if you are restricted to easy-to-use JSON.

I use both XML and JSON daily; they both have their place. I encourage
everyone who is fond of XML bashing to think about the extensibility
question. The Internet is quickly being filled with APIs based on JSON
that may be or may become quite brittle. On the other side, there are
many XML APIs that are so draconian as to be impenetrable and life
sapping.

I hope to see some reasonable proposals for extensibility in JSON in
the future; it certainly needs it. I think it is possible without
destroying the simplicity and terseness that make it popular, but I
haven't had enough time to find an answer myself. I also hope that
we'll see better models for working with XML data and better
representations for similar structures than XML itself.

