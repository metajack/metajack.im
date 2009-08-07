---
layout: post
title: JavaScript Function Tricks for Making Callbacks Better
tags: [javascript, code, strophe]
time: "21:02"
extended: ":EXTENDED:"
---

Have you ever needed to pass an extra parameter to a library callback?
Perhaps you were confused the first time your method callback was
invoked but didn't have the right `this` pointer.  Someone recently
e-mailed me asking how to do this in
[Strophe](http;//code.stanziq.com/strophe), and I figured it was time
to finally write up the techniques I use to solve these problems.

In these days of ever-larger JavaScript applications, callbacks have
become extremely common and important.  Unfortunately, JavaScript
doesn't have [bound
methods](http://stackoverflow.com/questions/114214/class-method-differences-in-python-bound-unbound-and-static/114267#114267)
like Python and not every JavaScript library allows passing arbitrary
state to callbacks, so getting the right state in callbacks can be
irksome.  It doesn't have to be this way though; JavaScript has plenty
of primitives available to build tools that make callbacks easier.

:EXTENDED:

## Bound Methods

In JavaScript, if you pass a method to a callback, that object that
the method belongs to is lost.  The `this` pointer will be the
function object itself, not the actual object that it would be if you
called `obj.foo()`.  You can make your own bound methods, though, and
some JavaScript implementations, like Firefox,  even have this built
in as `Function.prototype.bind()`.

The `bind()` method takes the function object it is called on, and
returns a new function object.  The new function will invoke the
original function with `this` set to the parameter passed to `bind()`.

For example, to create a Python style bound method, you'd write:

    var bound_method = some_obj.some_func.bind(some_obj);

Now when `bound_method()` is invoked, `some_func()` will have access
to `some_obj` through the `this` pointer, exactly as if it had been
invoked as `some_obj.some_func()`.

This is extremely useful because your code can store state in the
object as normal, and not have to worry about passing it along through
the callback chain.  When your method is invoked, it will know exactly
where to find the state it needs.

## Prepending Arguments

A lot of frameworks pass a well known set of parameters to callback
functions, but sometimes, you need a little extra piece of
information.  Wouldn't it be nice if you could create a callback that
prepended some arguments to the libraries normal parameters?  You can!

Here's an example using [Strophe](http://code.stanziq.com/strophe):

<code>
<pre name='code' class='javascript'>
// non-standard stanza handler which takes an extra argument at the beginning
function on_message(response, message) {
    var m = $msg({to: message.getAttribute('from'), type: 'chat'})
                .c('body').text(response);
    connection.send(m);
}

// register the handler for different cases
connection.addHandler(on_message.prependArg('Hi!'), null, "message");
connection.addHandler(on_message.prependArg('Hola'), null, "message");
</pre>
</code>

Two `<message>` stanza handlers are registered for the XMPP
connection; the first responds with "Hi!" and the second with
"Hola!".  `prependArg()` is used to add an extra argument at the
beginning of `on_message()`'s argument list.

The code for `prependArg()` appears below.

<code>
<pre name='code' class='javascript'>
Function.prototype.prependArg = function (arg) {
    var func = this;

    return function () {
        var newargs = [arg];
        for (var i = 0; i < arguments.length; i++)
            newargs.push(arguments[i]);
        return func.apply(this, newargs);
    };
};
</pre>
</code>


Strophe uses both `bind()` and `prependArg()` to make sure that
`XMLHttpRequest` events are sent along with the proper state since hte
XHR implemenations don't allow passing along arbitrary data with
callbacks.  I found found `bind()` to be extremely useful when trying
to build large JavaScript projects, as bound methods can make a lot of
tasks much easier.

Please leave a comment if you have a favorite function manipulation
trick in JavaScript!
