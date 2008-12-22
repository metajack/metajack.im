---
layout: post
title: Battle Of The Build Systems
tags: [autotools, cmake, code, python, scm, scons, waf]
time: "08:09"
extended: ":EXTENDED:"
---

One of the underreported things about Google's new [Chrome](http://www.google.com/chrome) browser is that [SCons](http://scons.org) is used to build many of its modules.  I chose SCons as the build system for [libstrophe](http://code.stanziq.com/strophe) several years back, and was mostly quite happy.  It is certainly a lot easier to get going than [autotools](http://www.gnu.org/software/autoconf/) and make.  It seems that since I last looked, several new build systems have popped up.

## autotools

Everyone who's built software for Linux is probably familiar with the `configure` script.  The `configure`, `make`, and `make install` steps are simple and work well much of the time.  However, the story is radically different for the poor developers who have to use the tools that generate the `Makefile` and `configure` script.

Using autotools is a giant pain, but it gets the job done.

## SCons

SCons came out of work done for the [Software Carpentry Competition](http://www.advogato.org/article/25.html) way back in 2000.  It is a replacement for `make` along with functionality similar to `automake` and `autoconf`.  It is written in Python, and it uses Python scripts for its input files, making it quite flexible and easy to understand.

It works well, but it doesn't seem to be extremely active.  Version 1.0 was finally released last month, but it took a long time to get there.  The upside of this is stability, and the downside is lack of features.  I recall being excited about the possibility of generating Microsoft DevStudio project files with it, but I cannot find any information on this anymore.

Check out the SCons team's [comparison page](http://scons.org/wiki/SconsVsOtherBuildTools) for their take on SCons versus the other choices.

## CMake

[CMake](http://www.cmake.org/HTML/index.html) is another alternative written in C++.  It has a [more traditional syntax](http://www.cmake.org/HTML/Examples.html) than SCons, but its feature list is long and impressive.  CMake generates native build system objects like Makefiles or Visual Studio `.sln` files.  

The KDE project tried to switch from autotools to SCons and never quite made it.  They ended up choosing CMake, and there is a [good article](http://lwn.net/Articles/188693/) at LWN about this transition.

## waf

waf is the newest one I have noticed, but it looks quite promising.  Like SCons, it uses Python for its configuration files.  Unlike autotools, it is apparently quite fast.  It is also built to be distributed with your project to avoid people needing to install it as a dependency.  SCons now has this as well.  This means it will work out of the box on any system with Python pre-installed, which is everything but Windows, and perhaps `py2exe` would solve the Windows issue.

waf is quite interesting, and I will definitely be exploring it further.  Using Python for the configuration files was very nice when I used SCons for libstrophe, so I'm glad to see that others are doing this as well.

The waf wiki has a [comparison page](http://code.google.com/p/waf/wiki/WafAndOtherBuildSystems) which evaluations waf in context with autotools, CMake, SCons, and others.  It makes for very interesting reading.

## Choices Are Good

It's nice to finally have some good alternatives to the classic tools.  I've already tried SCons with libstrophe, and I'm looking forward to giving waf and CMake a try the next time I'm experimenting.

If you've played with these or know of other good choices, please leave a comment.

:EXTENDED:


