---
layout: post
title: The State Of JavaScript Documentation Tools
tags: [code, documentation, javascript]
time: "23:28"
extended: ":EXTENDED:"
---

I've been working furiously over the last week to prepare a 1.0 release of <a href="http://metajack.im/2008/06/30/strophe-preview-xmpp-in-javascript/">Strophe</a>. For the C library Doxygen was an easy choice.  The markup is based on <a href="http://en.wikipedia.org/wiki/Javadoc">Javadoc</a>, and the tool just works.  For JavaScript, there are few choices, and most of the choices are just terrible.

<strong>Documentation Styles</strong>

There are two ways to do in-code documentation.

The first way is <strong>implicit</strong>. The tool parses the code, finding which things are functions and which things are classes, and then grabs comment blocks located near these structures.  This method requires detailed knowledge about the programming language.

The second way is <strong>explicit</strong>.  The tool requires the documentation author to notate what is what.  This requires little information about the programing language since most languages share syntactic structures like functions, classes, variables, and so on.  The generating tool needs to know only what comments look like.

Some tools support one of these methods, and some support both.  Ideally they would all support explicit documentation, but also help you make the documentation more concise by figuring out what you are documenting automatically.  Keep these distinctions in mind while reading about the tools below.

<strong>The Choices</strong>

<strong>Doxygen</strong>.  <a href="http://www.doxygen.org/">Doxygen</a> does not support JavaScript, and it is not clear why, other than no one has gotten around to it.  It must be relatively hard to do because the current workaround involves a <a href="http://jsunit.berlios.de/internal.html">non-trivial Perl script</a> to translate JavaScript source into pseudo-C++ code which is then fed to Doxygen.  I tried to find a way to download this script but failed, and I was not willing to cut and paste from the browser or spend time trying to find and check out the subversion repository since the script is not in the distributed source.

It seems weird that it does not support any language it knows the comment syntax for, since it allows many kinds of explicit documentation.  Maybe the authors will fix this omission someday.

<strong>JSDoc</strong>.  Next up was <a href="http://jsdoc.sourceforge.net/">JSDoc</a>, which also has Javadoc style syntax.  Out of the box on Mac OS X, JSDoc segfaults.  It seems to be related to recursion depth of the regular expressions, and installing a Perl from source worked around the issue.  The problem with JSDoc is that it assumes a lot about how you write the code and allows no explicit documentation.  It cannot detect constructors inside JSON style object definitions and doesn't seem to deal well with prototypes.  If you program in the style it supports, it probably works great, otherwise you are screwed.  In addition to this, JSDoc produces the worst HTML output I've ever seen.  I think it could give early versions of FrontPage some competition in this regard.  Don't take my word for it though; just look at <a href="http://jsdoc.sourceforge.net/example/Bar.html">their example</a>.  It has all the text content inside of &lt;ul&gt; tags!

<strong>HeaderDoc</strong>.  Apple has written a tool called <a href="http://developer.apple.com/darwin/projects/headerdoc/">HeaderDoc</a> which does documentation for several languages, including Objective-C and JavaScript.  I believe this is because it is more in the explicit camp, but I haven't looked at the code. This tool is actually pretty neat, but the output is not that great.  It includes the entire function in the documentation for example.  It's simple, and it works, but not much else.

<strong>Naturals Docs</strong>.  <a href="http://www.naturaldocs.org/">Natural Docs</a> output <a href="http://people.chesspark.com/~jack/strophe-preview/doc/files/strophe-js.html">looks pretty nice</a> out of the box.  It supports a number of languages including JavaScript.  It has two levels of language support.  First, you can tell it what comments look like and notate your code explicitly.  It also has full implicit support for some languages, although JavaScript is not one of them.  It unfortunately has Javadoc style comment support only when in full implicit mode.  This is not that big of a deal since its <a href="http://www.naturaldocs.org/documenting.html">native commenting style</a> is simple and works well.

<strong>Natural Docs For The Win</strong>

In the end, the choice is simple for JavaScript.  HeaderDoc and Natural Docs are the only two that work in the general case.  Natural Docs is the clear winner on quality of output alone, but it also has a lot of other qualities that are great.  It is configured by simple text files, and it is easy to define support for new languages.  This gives it a huge advantage over tools like Doxygen or HeaderDoc which seem a lot harder to work with if you aren't starting in a supported language.

Natural Docs is not without its issues, but they are mostly minor.  The indexes for grouped documentation don't seem to be generated correctly, but I can forgive this since most of the other tools had no indexes at all.  It also can't document part of a class in one place and part in another unless you don't mind the documentation also showing up in two locations.  I think both of these problems could be easily fixed if they bothered you.  I was able to work around the latter easily with very minor code tweaks.

<strong>An Example</strong>

You can see the <a href="http://people.chesspark.com/~jack/strophe-preview/doc/files/strophe-js.html">Strophe preview documentation</a> to get an idea of what the output look like.  Here is what the input looks like for a typical function.

<tt>
/** Constructor: Strophe.Connection
*  Create and initialize a Strophe.Connection object.
*
*  Parameters:
*    (String) service - The BOSH service URL.
*
*  Returns:
*    A new Strophe.Connection object.
*/
</tt>

I think the output and tool are nice enough to use that I will probably convert the C version of Strophe to Naturals Docs as well, instead of using Doxygen.

Hopefully this inspires some people to document their code better.  I'm sure I'm not the only one that could improve in this area.

:EXTENDED:


