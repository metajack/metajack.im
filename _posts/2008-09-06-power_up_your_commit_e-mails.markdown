---
layout: post
title: "Power Up Your Commit E-mails"
tags: [code, email, gmail, subversion]
time: "10:45"
extended: ":EXTENDED:"
---

Every project I work on has a e-mail list for source code repository commit messages.  These are incredibly useful for keeping track of progress and for informal code review.  These emails are usually simple and utilitarian, but they don't have to be.  We've powered up our commit e-mails at [Chesspark](http://www.chesspark.com/), and you can too.

:EXTENDED:

[Subversion](http://subversion.tigris.org) comes with scripts that generate commit e-mails.  These scripts produce basic output that looks something like the picture below.

<center><a href="http://metajack.im//svn-email-1.png"><img src="http://metajack.im//svn-email-1.png" alt="svn-email-1.png" border="0" width="400" height="208" /></a></center>

Wouldn't it be great if you could have colorized HTML output?  While setting up commit e-mails for the XSF repository, [Peter](http://stpeter.im) stumbled across a tool that did this - [SVN::Notify](http://search.cpan.org/dist/SVN-Notify/).  This got me quite excited, as I depend a lot on these e-mails, so a few hours later our commit messages began to look like this second picture.

<center><a href="http://metajack.im//svn-email-2.png"><img src="http://metajack.im//svn-email-2.png" alt="svn-email-2.png" border="0" width="400" height="278" /></a></center>

This is a huge improvement - much more readable and much nicer to look at.

Unfortunately there is a small problem.  SVN::Notify produces output that contains `<style>` blocks for CSS formatting, and these are completely stripped out by some Web e-mail applications, including Gmail.  It took a little bit of hackery to modify SVN::Notify to use inline `style` attributes instead.

My only complaint so far is that it doesn't have as nice of output as [Trac's](http://trac.edgewall.com) internal colorizer, but it is close.  For anyone who wants the inline style patch, I have included it below.  The patch was done by [Collin Grady](http://collingrady.wordpress.com/).

Download <a href="http://metajack.im/patches/svnnotify-inline-styles.diff" title="svnnotify-inline-styles.diff">svnnotify-inline-styles.diff</a>.
