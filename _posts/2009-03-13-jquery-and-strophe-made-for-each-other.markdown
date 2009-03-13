---
layout: post
title: "jQuery and Strophe: Made for Each Other"
tags: [xmpp, jabber, javascript, jquery, strophe]
time: "15:50"
extended: ":EXTENDED:"
---

[Strophe](http://code.stanziq.com/strophe) is a beautiful library for
building XMPP applications in JavaScript.  It has a lot of nice
features to help you build stanzas and respond to various event
stanzas.  It is built on top of the DOM, and unfortunately, the DOM is
not always fun to work with.  Luckily, we have an excellent DOM slicer
and dicer that we can use alongside Strophe, the
[jQuery](http://jquery.com) library.

:EXTENDED:

## The Hard Way

Let's take a look at what the code looks like for the traditional DOM
method of manipulating incoming XMPP stanzas.

Our first example stanza handler is for receiving service discovery
information, or in XMPP parlance, `disco#info` stanzas.  Our code will
pull out the feature information from the stanza, and pass that along
to someone else.  

<code>
<pre name='code' class='javascript'>
function onDiscoInfoResult(stanza)
{
    var result = []
    var features = stanza.getElementsByTagName("feature");
    for (var i = 0; i < features.length; i++) {
       result.push(features[i].getAttribute("var"));
    }

    doSomethingWithFeatures(result);
}
</pre>
</code>

The disco code isn't too bad, but the DOM gets a lot worse the more
complicated the manipulations.

Next, let's look at Strophe's [echobot
example](http://code.stanziq.com/cgit/strophe/strophejs/tree/examples/echobot.js).

<code>
<pre name='code' class='javascript'>
function onMessage(msg) {
    var to = msg.getAttribute('to');
    var from = msg.getAttribute('from');
    var type = msg.getAttribute('type');
    var elems = msg.getElementsByTagName('body');

    if (type == "chat" && elems.length > 0) {
        var body = elems[0];

        log('ECHOBOT: I got a message from ' + from + ': ' + 
            Strophe.getText(body));
    
        var reply = $msg({to: from, from: to, type: 'chat'}).cnode(body);
        connection.send(reply.tree());

        log('ECHOBOT: I sent ' + from + ': ' + Strophe.getText(body));
    }

    // we must return true to keep the handler alive.  
    // returning false would remove it after it finishes.
    return true;
}
</pre>
</code>

This still isn't terrible, but we can see already that there are a lot
of calls to long functions and dealing with the results of
`getElementsByTagName`.  Looping has to be done manually.  If we need
a specific element of the hierarchy, then digging it out of the DOM is
pretty painful.

## The Easy Way

jQuery makes DOM manipulations really, really simple.  You can dig out
very precise pieces of the DOM, manipulate them in aggregate, and it
even takes care of much of the pain of looping for you.

Here are the same two examples using jQuery.

<code>
<pre name='code' class='javascript'>
function onDiscoInfoResult(stanza)
{
    var result = $(stanza).find('feature').map(function () {
        return $(this).attr("var");
    }).get();

    doSomethingWithFeatures(result);
}
</pre>
</code>

In the disco info example, jQuery's `map()` function has made it really
easy to grab a bunch of things at once, do something to them (in this
case, pulling out a specific attribute value), and then throw the
results into an array.

Notice that jQuery is happy to take our XML stanzas as input, just by
passing them into the `$()` function.  It then works just as normal,
except with our single stanza as its document instead of the HTML
page.

Here's the echobot example:

<code>
<pre name='code' class='javascript'>
function onMessage(msg) {
    $(msg).find("message[type='chat'][from]:has(body)")
        .each(function () {
            var body = $(this).find("body:first").text();
            var from = $(this).attr("from");

            log('ECHOBOT: I got a message from ' + from + ': ' + body);

            var reply = $msg({to: from, type: "chat"})
                .c("body")
                .t(body);
            connection.send(reply.tree());

            log('ECHOBOT: I sent ' + from + ': ' + body);
        });
}
</pre>
</code>

The jQuery code is shorter and clearer because it doesn't have to do
any of the busy work of dealing with DOM.  Using jQuery's powerful
selectors, we have:

* picked the correct element out of the stanza
* checked that the stanza made sense
* done nothing when the stanza doesn't match

This code is actually more robust than the other version because we
never bothered to make sure there was a `from` attribute originally.

## jQuery is not Just the Inspiration

jQuery's design has certainly influenced Strophe, most notably with
the builder syntax.  It is not just an inspiration, however, as its
powerful selectors and looping make it perfect for using to slice and
dice incoming XMPP stanzas.

I'm sure it was never intended for such a purpose, but it is a
testament to jQuery's good design that it just works, even in domains
that are unexpected.

I have to say that working with XMPP stanzas in JavaScript is by far
my preferred environment due to jQuery's powerful selectors and
Strophe's really convenient builders.  I hope that this will
eventually find its way into Python, Ruby, Erlang, and other languages
that do heavy XMPP lifting.
