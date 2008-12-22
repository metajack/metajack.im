---
layout: post
title: "Building Ejabberd Modules: A Build Tool Battle Won By Autotools"
tags: [autoconf, autotools, cmake, code, ejabberd, erlang, scons, waf]
time: "17:07"
extended: ":EXTENDED:"
---

I'm building some new Erlang modules related to [OpenMicroblogging](http://openmicroblogging.org) and thought it would be good build them properly.  I wanted to be able to detect whether [Erlang](http://www.erlang.org) was installed, look for [ejabberd](http://www.ejabberd.im) header files, nsure that the ejabberd behaviors I needed were available, and compile and install the module.  Having recently written about [various new build systems](http://metajack.im/2008/09/07/battle-of-the-build-systems/), I decided to explore these to find an acceptable solution to my problem.  

The short answer is that it wasn't a very fun way to spend my time, and despite my strong dislike of [autotools](http://www.gnu.org/software/autoconf/), I ended up using that in the end.  If you'd like the gory details as well as example code, keep reading.

:EXTENDED:

## First Attempt With Waf

[Waf](http://code.google.com/p/waf/) seemed quite promising when I looked at it before.  It used Python files to describe builds, had separate configuration and build steps, and it was even shippable along with the code.  I decided to start with waf.

The first problem I ran into is that the documentation for waf is either extremely out of date or much newer than the latest stable release.  Either way, the examples in the documentation failed completely because the API had changed.  I was able to get some very basic examples working after digging around for a while.

The second problem is that while waf is capable of building arbitrary things, there is essentially no documentation for how to set up custom builders.  The documentation assumes that everyone will be satisfied with the baked in languages.  Since I'm compiling Erlang, and Erlang isn't yet supported in waf, I was out of luck.  I made a half-hearted attempt to investigate the baked in builders in hopes of it being pretty easy, but I became frustrated and gave up.

Another thing I noticed about waf is that there does not appear to be a separate install step.  Installation seems to be part of the build step, and various options make it install happen or not while building.  This seems like a weird omission, although I am probably missing something.

## Second Attempt With SCons

I've used [SCons](http://www.scons.org) before for [Strophe](http://code.stanziq.com/strophe).  It's not perfect, but I remember it working well enough and saving me from the horror of autotools.  In the three years since I first played with SCons, it hasn't changed much.  What it has gotten is bug fixes and documentation.  I was much more hopefully that SCons would work for me where waf had failed.

A Google search revealed that there was some 3rd party [Erlang support for SCons](http://pupeno.com/projects/scons-erlang).  The Web site is half broken, but I did manage to find and download the code.  It seems reasonable complete in that it supports building and dependency scanning for normal Erlang modules, Erlang applications, and EDoc documentation files.  There is a real problem with both SCons and the Erlang support though.

The issue is that SCons has to be installed for someone to build your package, and on top of that, SCons Erlang has to be installed as well.  SCons actually has a facility called `site_scons` for including extra build tools in your distribution so that they are available without having to install more stuff.  I think that SCons Erlang could be made to live in `site_scons`, but I'm baffled why the author didn't make this the default.  The [SCons documentation on builders](http://scons.org/doc/1.0.1/HTML/scons-user/x3627.html) gives an example of this, and the custom builder examples in the [SCons wiki](http://scons.org/wiki/) follow suit.

I did make an attempt to write some simple Erlang builder rules in `site_scons`, but I could not get the code to function as the documentation suggested it should.  I suspect I was missing some small detail that is mentioned elsewhere in the manual than the examples I was following.

The final straw for me was the lack of a separate configuration step.  This needs an example to explain fully.

In order to find the ejabberd headers and modules, I need to pass in the path where ejabberd was installed.  In autotools, this would be done with an argument to configure like `--with-ejabberd=/path/to/ejabberd` or `--prefix=/ejabberd/prefix`.  SCons can take arguments but these have to be passed every time as there appears to be no built in facility for persisting the configuration for the build between invocations of SCons.  

I think such a persistence facility could be written, or possibly has already been, but I couldn't find one and I was not in the mood to write my own.  After all, I already had the work of writing tests for finding headers and modules plus the work of getting SCons Erlang to work in `site_scons`.

## Third Attempt With CMake

I didn't spend much time with CMake. I perused the documentation to see if it already supported Erlang or if it had examples on how to create custom builders.  My impression was that it supports C and C++ out of the box and not much else, and I could not find any examples of how to set up build rules for arbitrary languages.  I was left with a Win32 taste in my mouth due to the filename convention of `CMakeLists.txt` as the build file names.  

Since I didn't see any examples for custom builders, and the syntax of the build description files was novel, I punted.

## Final Attempt With Autotools

By this time I decided to give in and try autotools.  I managed to make it work eventually, but I ran into a lot of problems along the way.

### Automake, You Suck

I first started with a basic `configure.ac` script which used [automake](http://www.gnu.org/software/automake).  Because automake is fairly hardcoded around C and C++ based development, you have to jump through some hoops to make it deal with Erlang at all.  Essentially you have to tell it that the Erlang files are data files derived from source files that automake shouldn't care about.  Here is an [example](http://sources.redhat.com/ml/automake/2002-09/msg00067.html) I found on the mailing list:

    beam_DATA = netaccess.beam
    EXTRA_DIST = netaccess.erl
    CLEANFILES = $(beam_DATA)
    .erl.beam:
        @ERLC@ -b beam $@ $<

Sure this works, but it is a big, ugly hack.

Automake sucks for more reasons than not being very nice with Erlang files.  It creates a huge mountain of build steps.  It gets the job done, but the screen is filled with useless build output from all the intermediate steps.

I now that standard Makefiles can be simple and elegant, so I abandoned automake and crafted my own.

### Autoconf Knows Erlang

One of the happy discoveries is that autoconf already understands Erlang.  In fact, it has numerous Erlang examples in the [manual](http://www.gnu.org/software/autoconf/manual/autoconf.html).  I added my `AC_ERLANG_NEED_ERLC` line and dived in.

My first job was to detect header files.  Autoconf does this for C type headers but does not include any support for Erlang headers.  I decided to write support for this building on top of the `AC_COMPILE_IFELSE` macro, which attempts to compile an Erlang problem when `AC_LANG_ERLANG` is effect.  This immediately fails because autoconf has a huge bug in its Erlang support.  It never defines `$ac_objext` so can't create BEAM files.  This is a [known issue](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=454798), but I don't understand how this code ever made it into autoconf in the first place if such a basic bit of functionality didn't work.

This can be worked around, and here is my header checking macro, `ERL_CHECK_HEADER`:

    # Check if we can find Erlang header files.
    AC_DEFUN([ERL_CHECK_HEADER],
             [AC_MSG_CHECKING([for $1])
              AC_LANG_PUSH(Erlang)
              ac_objext=beam
              AC_COMPILE_IFELSE(
                [AC_LANG_PROGRAM([[-include("$1").]], [[ok]])],
                [AC_MSG_RESULT([ok])
                 $2],
                [AC_MSG_RESULT([not found])
                 $3])
              AC_LANG_POP])

I use this to detect `ejabberd.hrl` like so:

    ERL_CHECK_HEADER(ejabberd.hrl, [], 
      [AC_MSG_ERROR([ejabberd.hrl is required.])])

All is well and good so far.  The next problem is to detect whether specific modules are available.  Specifically, I want to know if autoconf can find the `gen_mod` module which any ejabberd module will need.  The  location of this module will be needed during the compile stage.

Just like the header check, there isn't much in autoconf's Erlang support to help us out.  It does have an `AC_ERLANG_CHECK_LIB`, but this only finds Erlang libraries, not modules.  Moreover, it's broken too.  There was a [regression](http://www.nabble.com/AS_ECHO-calls-finding-their-way-into-calls-td19487768.html) in autoconf 1.62 and later, still unfixed, which prevents `AC_RUN_IFELSE` from working.  This sucks, because `AC_RUN_IFELSE` is exactly what we need to write the `ERL_CHECK_MODULE` macro.

Patching this in `aclocal.m4` fixes the regression, but we also need to pass in some options to `erl` when it runs the program.  This is, of course, not supported at all, and we have to patch this as well by passing in `ERLFLAGS` when `erl` is run so that it can hope to find the modules we're looking for.  The resulting macro is very similar to the one above except for the redefinition of `AC_LANG_ERLANG` that is needed to make it do anything useful.  

I've put up my basic ejabberd module autoconf project skeleton [here](http://metajack.im/code/mod_autoconf.tar.gz) others to study or enjoy.

## A Note On Other Options

Notably missing from my attempts are plain Makefiles or Erlang Emakefiles.  Normal Makefiles work fine, but they do not provide any facility for configuration or detection of libraries.  Emakefiles are even worse, since there doesn't seem to be any standard way to include shell variables.  I didn't want to hard code the configuration or require special environment variables like `EJABBERD_HOME`.  I realize autoconf is more than is needed for simple modules, but my goal was to explore build systems more than it was to do something practical.

That said, if you are going to package up a 3rd party ejabberd module, having configuration detection and support is very helpful for users.  Most people have no idea how to build C, much less Erlang.  The less we have to expose to them the better.  The benefit of autotools is that many users will already be familiar with `./configure`, `make`, and `make install`.

Several people suggested I check out [zc.buildout](http://pypi.python.org/pypi/zc.buildout), but this appears to be a meta system for configuring a bunch of dependencies along with a project that runs in the "buildout".  This reminds me a lot of something like pbuilder a little more cleverly done.  It also seems very focused on Python.  Perhaps someone familiar with it can chime in as to how appropriate it is for something written in Erlang or C.

## Thoughts

I was extremely disappointed in the non-autotools options.  Of the other three, SCons had the best documentation and examples by far.  Waf and CMake left a lot to be desired if one is not building a C project.

I'd love to give the other systems another shot, and here's what I'd like to see before doing so:

* **SCons** - I'd love to see a way to include SCons with my distribution so that the only dependency is Python.  Waf does this very well, as does autotools.  Some improvements in the `site_scons` documentation would be nice as well.
* **waf** - Waf really needs to get its act together documentation wise.  It's extremely frustrating to invest time in reading the documentation only to find out that it does not apply to the current version of the code.  Build systems like waf need to realize that they fill a great niche that is under-served by autotools, which is making custom build tools much easier to develop.  Lack of any examples in the documentation on how to do this make it harder than autotools.
* **CMake** Custom build support examples need to be in the documentation.  I'm willing to put up with arcane syntax as long as it works and is well documented.  If I have to read the code and pour through the build files of large projects to find information, I might as well read the source code for waf and solve the problem in a familiar domain.

As always, I'd appreciate your comments.  Are you suffering with the un-fun, but reliable, autotools, or do you have a favorite alternative?
