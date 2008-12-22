---
layout: post
title: Custom Behaviors In Erlang
tags: [code, ejabberd, erlang]
time: "21:59"
extended: ":EXTENDED:"
---

[Erlang](http://www.erlang.org) behaviors are similar to interfaces in other languages.  They are essentially a required set of callbacks.  The [OTP](http://www.erlang.org/doc/design_principles/part_frame.html) libraries use them to separate the functional parts of a server from the non-functional parts, letting developers quickly leverage common design patterns.  I wrote about Erlang behaviors in my [ejabberd module tutorial](http://metajack.im/2008/08/28/writing-ejabberd-modules-presence-storms/) where we implemented ejabberd's `gen_mod` behavior.  Sometimes you'll want to craft your own behaviors that other developers can use.  



:EXTENDED:

## Making Custom Behaviors

Making your own behaviors is very simple, but for some reason is completely undocumented.  Aside from the `gen_mod` behavior of ejabberd as an example, the only information I could find was [a mailing list post](http://metajack.im/2008/08/28/writing-ejabberd-modules-presence-storms/index.html).

To create your own behavior, you must make a module that exports a function, `behaviour_info/1`.  Note that while Erlang is American-English-friendly in regards to declaring behaviors, it is not as friendly when you are defining them.  For example, you can use either `-behavior(gen_server).` or `-behaviour(gen_server).` when you declare you module implements the `gen_server` behavior, but if you name the `behaviour_info/1` function without the 'u' it will not work.

`behaviour_info/1` just needs to return the list of required exports of an implementation.  Here's an example.

    -module(gen_foo).
    -export([behaviour_info/1]).
    
    behaviour_info(callbacks) ->
        [{foo, 0}, {bar, 1}, {baz, 2}];
    behavior_info(_) ->
        undefined.

This declares three callbacks for the `gen_foo` behavior: `foo/0`, `bar/1`, and `baz/2`.  `behaviour_info/1` simply returns an array of 2-tuples with the function name and arity.

When a module declares that it implements `gen_foo` now, the Erlang compiler will check to make sure it exports and implements the required callbacks, and it will print warnings if this is not the case.

## Behavior Helpers

`gen_foo` is just a toy example.  A real behavior implementation is likely to have helper functions just like the OTP behaviors.  For example, ejabberd's `gen_mod` has helper functions like `gen_mod:get_opt/2` which make it easy to access a `gen_mod` module's options.
