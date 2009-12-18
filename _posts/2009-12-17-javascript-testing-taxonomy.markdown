---
layout: post
title: JavaScript Testing Taxonomy
tags: [javascript, testing, jquery, yui, windmill, jstestdriver, qunit]
time: "18:58"
extended: ":EXTENDED:"
---

Everyone talks a lot about testing, but it seems few people actually
do much of it. I certainly am guilty of not doing as much automated
testing as I should, but I am working hard to improve. I write a *lot*
of JavaScript, so I've been spending a lot of time experimenting with
a range of JavaScript testing tools. There are a lot of different
options, and I've come to the conclusion that you need several of
them.

## xUnit Frameworks

There are tons of xUnit inspired testing frameworks for JavaScript:
[QUnit](http://docs.jquery.com/qunit),
[JsUnit](http://www.jsunit.net), [YUI
Test](http://developer.yahoo.com/yui/3/test/), etc. There are probably
over a dozen of these, and many of the other testing tools include
their own xUnit style assertion framework.

Almost all of these work by having you create an HTML page that serves
as the test runner.  To run or re-run the tests, you simply open the
page in a web browser and off it goes.

The tests that one writes are quite valuable, but the way you run them
leaves a lot to be desired. For example, to test in multiple browsers
you must hit refresh in all those browsers, and there is no way to run
a specific test in isolation easily.

These HTML test runners have one very good quality though; they make
it trivial for an outside person to run the tests.  All they have to
do is open up the HTML page in a browser, and the tests run.

Because of the HTML runner limitations, I think this can't be the only
way you run tests. However, because it's so easy to run tests this
way, I think it's important to have it, since users can easily use it
to run the tests without any effort.

## Testing From the Command Line

Developers want to run tests from their IDEs, run specific tests only,
and avoid hitting refresh in lots of open browsers. This is commonly
achieved by making the tests runnable from the command line, and there
are a number of frameworks which do this.

[EnvJS](http://code.google.com/p/envjs/) and a few others set up
pseudo-browser environments inside stand-alone JavaScript interpreters
like
[Rhino](http://www.mozilla.org/rhino/). [JsTestDriver](http://code.google.com/p/js-test-driver/)
captures browsers and provides a way to run tests quickly and easily
inside them, without having to interact with them directly.

These types of tools make JavaScript testing very similar to testing
in other languages. You can run tests in isolation, automate the
running of tests, and run tests extremely quickly.

Unfortunately, these tools have their drawbacks.  It often takes some
infrastructure to run the tests. For example, the test runner may need
Rhino or another JavaScript interpreter. Also, running the tests
outside of a true browser environment may not lead to accurate
results.

## Testing Farms and Integration Tests

None of the previous tools help much with integration tests, and very
few of them have any kind of support for controlling browsers. For
those tasks there are tools like [Windmill](http://www.getwindmill.com) and [Selenium](http://seleniumhq.org).

Windmill, for example, can launch a browser, run a test suite, and
then shut the browser down at the end. It can also record and play
back user interactions, making it a great tool for integration testing
as well.

Either tool can be integrated with things like [BuildBot](http://buildbot.net) to
automatically run test suites upon commit, and some Selenium
developers even have a [startup to run tests in the cloud
](http://saucelabs.com/) on a wide
variety of browsers and platforms automatically.

The main downside of these tools is that they are slow. It takes time
to launch and terminate a browser, and this makes them less than ideal
for test driven development where a developer is running the test
suite many times.

## You Probably Need Them All

I think each of these three kinds of tools has a place in your testing
workflow.

HTML test runners are useful for easily running the tests and
providing users and external developers a hassle-free way to write
and run tests. After all, if it's not dead simple to run and write
tests, people won't bother.

Command line driven tools are a necessity for the test driven
developer. Tests must be able to run extremely fast since they will
run multiple times, and it must be possible to run just the specific
tests you want.  It takes a little work to set up, but the result is a
much more pleasant testing experience.  A tool like JsTestDriver can
also make it just as easy to test in many browsers at the same time,
all controlled from the command line and lightning fast.

Finally, if you want a test farm or to do more system-level tests,
tools like Windmill and Selenium are there.  Developers might interact
directly with JsTestDriver or an HTML runner, but the continuous build
systems which run the suite on every commit aren't nearly as sensitive
to run speed. Also, starting from a fresh browser every time can be
helpful to make the test runs consistent.

Fortunately, all these tools can usually be made to work around a
basic xUnit style assertion framework.  The tests themselves don't
need to be duplicated and remain simple.

## My Current Experiments

I'm currently evaluating YUI Test for the HTML runner and assertion
framework. It seems quite well designed, and I really like it's
ability to simulate common user interactions for unit testing UI
controls. That kind of attention to detail is missing from most of the
other, similar frameworks like QUnit.

I hate running tests in the browser, however pretty the HTML, so I'm
using JsTestDriver from the command line. I can easily capture Safari,
Chrome, and Firefox at the beginning of the day and run tests against
them all simultaneously as I'm writing code. With a little bit of
configuration, I have got it using YUI Test instead of its built-in
assertion framework.

I still need to set up a test farm so that I can run these tests on
the full range of platforms and browsers, and I'm thinking about
modifying Windmill to use YUI Test in order to facilitate this.

I haven't even started evaluated the various mocking frameworks that
exist. Specifically for [Strophe](http://code.stanziq.com/strophe),
I'll need to mock XMLHttpRequest interactions in order to test
anything interesting. I also haven't looked at code coverage
reporting, but several frameworks I mentioned have some support for
this.

## What About You?

I'd love to hear your experiences with JavaScript testing. Please let
me know what tools you've found useful and how they've worked out for you.
