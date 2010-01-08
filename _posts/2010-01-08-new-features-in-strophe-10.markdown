---
layout: post
title: New Features in Strophe 1.0
tags: [xmpp, jabber, strophe, javascript, code]
time: "10:26"
extended: ":EXTENDED:"
---

On January 1st, 2010, [Strophe 1.0 was released](http://metajack.im/2010/01/01/celebrate-2010-with-strophejs-10/). This release
included several new features that I haven't talked about before, so I
wanted to make sure they got some attention. These features are the
ability to match on bare JIDs in handlers and to flush pending
outgoing data immediately to the connection manager.

## Matching Bare JIDs

The `addHandler()` function has always performed exact matching on its
criteria. If you specified that your handler should match a stanza
with a `from` attribute of `darcy@pemberley.lit`, then it
would fail to match against a stanza with a `from` attribute of
`darcy@pemberley.lit`.

Sometimes this is exactly the behavior your want, but it can also get
in the way when you care only about the bare JID. Your application may
not care what the resource portion of the JID is set to and needs only
to check that the origin is as expected. One example would be to match
incoming chat messages for a user regardless of which connection they
are from.

Previously, you could accomplish this by setting your handler criteria
to `null` and doing the extra check yourself within the handler. Now
you can have the Strophe matching logic take care of this tedious task
for you:

<code>
<pre name='code' class='javascript'>
// connection is the Strophe.Connection instance
connection.addHandler(my_handler, null, 'message', null, null,
                      'darcy@chat.pemberley.lit`, {matchBare: true});
</pre>
</code>

The `addHandler()` function now takes a new, optional seventh argument
consisting of a dictionary of options. The only option currently
supported is `matchBare`, which defaults to `false` and controls
whether the JID matching is done on full or bare JIDs.

`my_handler()` will now be invoked for &lt;message> stanzas with a
`from` attribute of `darcy@pemberley.lit`,
`darcy@pemberley.lit/library`, or even
`darcy@pemberley.lit/longbourn`. This makes the handlers much simpler.

## Flushing Data

Strophe is designed for high performance by default, and to this end,
it queues outgoing data sent to the `send()` function until the next
idle period, which will occur after 100 milliseconds.

The benefit of this delay is that if you call `send()` many times in
the same handler or in the same chain of functions invoked from a
handler, all this data will end up in a single HTTP request to the
connection manager. If we sent all data immediately, each stanza would
be sent in its own request. The small idle period is short enough that
this causes little noticeable delay.

However, there are times when you want to force the data to be sent
immediately, and before version 1.0, this was not possible in
Strophe. The most common example is when you want to do some cleanup
when the user navigates away from your application. If you simply put
the cleanup code in the `onbeforeunload` event handler, the browser
will invoke the code and then immediately tear down the JavaScript
environment before the idle timer has a chance to fire. The cleanup
stanzas would never get sent!

Strophe now includes the `flush()` function which forces all pending
data to be sent immediately. Just call `connection.flush()` at the end
of your handler, or whenever your code needs a new HTTP request to be
sent. This fixes the problem of graceful tear-down in browsers, but it
also allows you to eke out a little bit more performance in terms of
low latency by using `flush()` to tell Strophe when your code done
generating data.

As with most projects, these features were suggested by the kind
Strophe community. Strophe would not be what it is without your help,
feedback, and support. I hope you enjoy them!
