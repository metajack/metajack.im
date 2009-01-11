---
layout: post
title: Some Reasons I Dislike Autotools
tags: [autotools, code]
time: "23:55"
extended: ":EXTENDED:"
---

I've [mentioned
before](http://metajack.im/2008/10/07/building-ejabberd-modules-a-build-tool-battle-won-by-autotools/)
that I'm not in love with the autotools (autoconf, automake, libtool,
etc), but they often get the job done.  I spent a few hours trying to
move the [libstrophe](http://code.stanziq.com/strophe) build system
from [SCons](http://www.scons.org) to autotools, and it reminded me of
why I dislike this tool chain so much.

* I dislike recursive makes; they are much slower.  I suppose one
  advantage of them is that you can run `make` from any subdirectory,
  but SCons managed to solve this without recursion, as does every VCS
  system on the planet.
* automake uses concise input files, but generates a build that is
  extremely noisy.  I have a hard time seeing any compiler warnings or
  other such messages as my screen is full of junk like verbose `-D`
  options that I did not ask for.
* libtool is just horrid.  It has the same noise problem as automake,
  but even more so.  It took me a bit of tinkering to figure out how
  to generate an `ltmain.sh` which it kept complaining was missing.
  Once the file was there, I know longer saw any normal `gcc` lines
  during the build.
* libtool adds so much extra output to configure I though I must have
  run `./configure` in the wrong directory.  It sent from a simple
  screen full, to about 3.  Why must it check for a compiler for every
  language?  I'm happy to inform you if I need the `f77` compiler,
  thanks.

I ended up getting a libtool-free system up and running, after trying
desperately to get something else besides autotools working.  

Some things have gotten better though.  Specifically dealing with
external dependencies in autoconf is much nicer than I remember now
that `pkg-config` is basically standard.  That used to be a mess back
in 2001 or so.

I think that, in general, automake has the right idea; something should be
generating native build machinery for make or various IDEs from simple
input files.  It's just unfortunate that the result is a big mess.
