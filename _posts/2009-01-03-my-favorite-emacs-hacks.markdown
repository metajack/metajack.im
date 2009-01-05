---
layout: post
title: My Favorite Emacs Hacks
tags: [code, emacs]
time: "23:42"
extended: ":EXTENDED:"
---

During the holiday downtime, I decided to spend a little time
improving my most some tools, specifically
[Emacs](http://www.gnu.org/software/emacs/).  While I was
experimenting and tuning I realized that I really love Emacs, and I
thought I'd share some of my favorite things about it.

:EXTENDED:

## Awesome daemon support

Once you start having a bunch of extra modules and customizations,
Emacs beings to take a while to boot up.  Fortunately we can just fire
up an Emacs server inside a running session, and then connect to it
via `emacsclient`.  

In Emacs 23 (not yet released, but very usable) the emacsclient can
even create new graphical (X or Cocoa) or text frames.  This means
that with `EDITOR` set to `emacsclient -t` it works just like a normal
console Emacs would, except that it starts *instantly* and has access
to all my already open buffers.

I used to use Vim at the command line because it loaded much faster
than Emacs, but now I can finally drop that habit.

## Interactively Do Things

[ido](http://www.emacswiki.org/emacs/InteractivelyDoThings) brings
[Quicksilver](http://blacktree.com/?quicksilver) and Spotlight type
search to Emacs.  It shows me possible fuzzy completions for what I'm
looking for whenever I look for files or want to change buffers.
Using ido has really increased my ability to get around in all my
projects quickly.

## nxml Mode

The nxml mode is an amazing thing.  It validates the XML document live
and tells you exactly whats wrong.  Just like a spell checker from a
modern word processor, it underlines the offending characters in red.
Moving the cursor over them tells you exactly what's wrong.

I use it for HTML, XSLT, and any other XML markup I'm working on, and
I never have to worry if it's correct.

## Yet Another Snippet

[yasnippet](http://code.google.com/p/yasnippet/) bring
[TextMate](http://macromates.com) style snippets to Emacs.  Now,
snippets are nothing new for Emacs; we've had [skeleton
mode](http://www.emacswiki.org/emacs/SkeletonMode) and similar things
for a long time.  yasnippet is just a lot easier.

My main use of yasnippet is to insert things like doctypes and other
long strings that have some information that I must complete.

## dabbrev

`dabbrev` is on by default in all the Emacs that I've run into, and it
allows you to dynamically auto-complete anything based on the words it
finds in your open buffers.  Invoking it multiple times will complete
longer and longer parts.

Just like everything with Emacs, it takes a good idea (text
completion) and makes it extremely general.  It works great on code,
blog posts, and anything else I happen to be writing.

## Find Tag (M-.)

Shortly after I started working with
[Monty](http://en.wikipedia.org/wiki/Chris_Montgomery) on the
[Xiph.org codecs (Ogg, Vorbis, Theora)](http://www.xiph.org) I noticed
that he was using his editor a level far beyond what I was used to.
The best thing I saw him do was `find-tag` which jumps to the function
definition of the function name under your cursor.  Using that, Monty
could surf around the code base at blinding speed.

`find-tag` uses information in special tag files to implement this.
Emacs can also do many other things with tags like project lists and
auto-completion.

## Flyspell

Flyspell brings word processor style spell checking into Emacs.  Just
like nxml mode's validation, Flyspell checks the spelling of words
live, and gives visual indications where things have gone wrong.

Flyspell is also well supported in other modes, so that it knows which
parts to check and which parts to skip.  It's not perfect, but it is
extremely useful.

## Theming

A lot of people complain that Emacs is ugly, and the default
configuration is certainly not going to win any awards.  I will say
though that Emacs is extremely well though out from a usability
standpoint, and it mostly stays out of the way as much as possible.
It is nice to get color syntax highlighting though, and
[color-theme](http://www.emacswiki.org/emacs/ColorTheme) does just
that.

My personal favorite is `color-theme-dark-laptop`, which is somewhat
similar to TextMate's Twilight theme.

## Help In All Forms

Last, but absolutely not least, is the help system.  Emacs has the
best help system I have ever seen.

First, you can get help in any number of ways:

* Use the interactive tutorial (`C-h t`)
* Read the manual (`C-h r`)
* Read various other manuals (usually I'm after the Emacs Lisp manual
  and tutorial) (`C-h i`)
* Look up what keys do what in the current buffer (`C-h b`)
* Look up what some key does by pressing the key (`C-h k`)
* Look up the name of a function (`C-h f`)
* Look up the name of a variable (`C-h v`)
* Look up functions about some topic (`C-h a`)

Not only can you find all this information easily, but if you have the
source code package installed, it will link you directly to the
implementation.  This means if I am looking up information about a
particular Emacs function, within a few key presses I'm staring at the
actual function.

Emacs is probably the only system for which I don't use Google as the
first place for answers to my questions.  Nearly everything is a few
key presses away, even if you have no idea what you are looking for.

## Emacs Rocks

I still have tons to learn about Emacs, but it already fits like a
glove.  Did I mention that it works the same whether I'm on OS X or
Linux or in a terminal or the windowing system?

For those of you who also use Emacs, I'd love to hear about your
favorite things.
