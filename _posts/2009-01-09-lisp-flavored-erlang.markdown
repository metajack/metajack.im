---
layout: post
title: Lisp Flavored Erlang
tags: [lisp, erlang, code, lfe, reia, python, ruby]
time: "23:59"
extended: ":EXTENDED:"
---

While I was reading feeds today, I came across a reference to [Lisp
Flavored
Erlang](http://forum.trapexit.org/viewtopic.php?p=40268#40268) (also
see the [mailing list
post](http://groups.google.com/group/erlang-questions/browse_thread/thread/adfe375287d4bef4/4a9127e701f5e2db#)).
I'd heard about this several times before, but had not tried it.
Since my [Erlang
complaints](http://metajack.im/2009/01/05/brevity-and-programming-languages/)
are still fresh in my mind, I decided to give it a go.  Besides, I
needed a mental break after spending all day concentrating on real
work.

:EXTENDED:

Here is a simple `gen_server` module written in LFE.  So far I'm
really liking this.

<code>
<pre name='code' class='lisp'>
;; count_server.lfe
;; Simple gen_server example.

(defmodule count_server
  (behavior 'gen_server)

  ;; gen_server exports
  (export 
   (init 1)
   (handle_call 3)
   (handle_cast 2)
   (handle_info 2)
   (terminate 2)
   (code_change 3))

  ;; public functions
  (export 
   (start_link 0)
   (current 0)
   (next 0)))

;; gen_server implementation

(defun init (args)
  #(ok 0))

(defun handle_call 
  (('next _ n)
   (let ((new (+ n 1)))
     (tuple 'reply (tuple 'ok new) new)))
  (('current _ n)
   (tuple 'reply (tuple 'ok n) n)))

(defun handle_cast (req state)
  (tuple 'stop #(error not_implemented) state))

(defun handle_info (info state)
  (tuple 'stop #(error not_implemented) state))

(defun terminate (reason state)
  'ok)

(defun code_change (oldvsn state extra)
  (tuple 'ok state))


;; public functions

(defun start_link ()
  (: gen_server start_link #(local count_server) 'count_server () ()))

(defun current ()
  (: gen_server call 'count_server 'current))

(defun next ()
  (: gen_server call 'count_server 'next))
</pre>
</code>

For those of you who are more into Python and Ruby, a Ruby like
language with Python's significant whitespace also exists for the
Erlang VM.  It's called
[Reia](http://wiki.reia-lang.org/wiki/Reia_Programming_Language).
Perhaps I'll check that out next.  

The nice thing about these, is they compile to `.beam` files just like
normal Erlang code, so you can use anything in Erlang, and anything in
Erlang can use these modules.

