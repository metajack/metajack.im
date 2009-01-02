---
layout: post
title: GTD Capture With Emacs OrgMode
tags: [gtd, emacs, code]
time: "13:01"
extended: ":EXTENDED:"
---

Ubiquitous capture is the part of
[GTD](http://en.wikipedia.org/wiki/Getting_Things_Done) that I am most
interested in.  While I am working I'll come up with random new
ideas, find unrelated bugs in code I'm working on, or find something I
need to remember later.  I want to make a note of these things without
causing much interruption to the task at hand.  I've tried a number of
solutions to this problem and have now got a great solution going
using my favorite editor, [Emacs](http://www.gnu.org/software/emacs).

Here's a small demo screencast:

<object><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id=2672740&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" /><embed src="http://vimeo.com/moogaloop.swf?clip_id=2672740&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="400" height="302"></embed></object>

:EXTENDED:

## Requirements

There are some basic requirements that I think any solution to the
capture problem must solve.

It should be immediately accessible from any application on the
computer.  I want to have some key binding that immediately lets me
jot down something quickly and then gets out of my way.

It needs to work everywhere I do.  I currently use both OS X and Linux
on different machines.  I don't want to have to capture only on one
machine, and I want the capture method to the be same on both.

## Why Emacs

If you use Emacs, then it makes a lot of sense to use it for capture.
If you don't use Emacs, then it probably doesn't, although
[OrgMode](http;//orgmode.org) is good enough to convert some people.

First, Emacs is everywhere.  It runs well on Linux, OS X, and Windows.

Emacs is also where I do a lot of my work already.  This means I
always have Emacs running, and many times when I am capturing
something, it relates to things I am doing in Emacs.  Notable
exceptions to this include Web browsing and e-mail.

Emacs comes with a remarkably useful extension called OrgMode.
OrgMode can be used like an outliner, but it also has hooks for to-do
lists and calendaring.  OrgMode integrates with
[Remember](http://www.emacswiki.org/emacs/RememberMode) which is an
Emacs capture tool.

These add up to most of a great capture solution.  All we need is some
glue.

## Capturing From Anywhere

The first requirement is that we be able to capture from anywhere.
This means we will need to globally bind some combination of key
presses to invoking the Remember functionality in Emacs.

Emacs has a server mode that allows other things to communicate and
control it.  This is a lot like AppleScript on OS X except that it is
done with [Emacs Lisp](http://en.wikipedia.org/wiki/Emacs_Lisp).  All
we need to do is send Emacs a command when the global hot key is
pressed.  This is easily accomplished with `emacsclient -e
'(some-command)'`.

Binding the hot key is done in the window manager preferences in
Linux.  Since my Ubuntu machines run compiz, I added a binding for
`<Control><Alt>backslash` to run `emacsclient -n -e
'(make-remember-frame)'`.  On OS X I used
[Spark](http://www.shadowlab.org/Software/spark.php) to bind the same
keys to a small bit of AppleScript which runs the same command as Ubuntu.

## Fine Tuning Emacs

Finally, I wanted Emacs to pop up a new, small window (what it calls a
frame) and let me start typing.  I also wanted Emacs to get rid of the
window as soon as I was finished, either by saving my note or
discarding it.  This took a little digging through Emacs documentation
and bits of code, but turned out not to be that hard.  

Here is my `make-remember-frame` code, along with the hooks it needs
to work.

<code>
<pre name='code' class='lisp'>
(defadvice remember-finalize (after delete-remember-frame activate)
  "Advise remember-finalize to close the frame if it is the remember frame"
  (if (equal "remember" (frame-parameter nil 'name))
      (delete-frame)))

(defadvice remember-destroy (after delete-remember-frame activate)
  "Advise remember-destroy to close the frame if it is the rememeber frame"
  (if (equal "remember" (frame-parameter nil 'name))
      (delete-frame)))

;; make the frame contain a single window. by default org-remember
;; splits the window.
(add-hook 'remember-mode-hook
          'delete-other-windows)

(defun make-remember-frame ()
  "Create a new frame and run org-remember."
  (interactive)
  (make-frame '((name . "remember") (width . 80) (height . 10)))
  (select-frame-by-name "remember")
  (org-remember))
</pre>
</code>

