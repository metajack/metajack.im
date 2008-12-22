---
layout: post
title: Debugging with Data Visualization
tags: [chesspark, debugging, startups, visualization]
time: "10:55"
extended: ":EXTENDED:"
---

We do quite a bit of data visualization at <a href="http://www.chesspark.com/">Chesspark</a>.  Of course we have the standard things like graphs from MRTG, Google Adwords, and Google Analytics, but we also track a number of other things.  For example, we track signups through each stage of <a href="http://www.chesspark.com/join/">our signup process</a>.  This let's us see at a glance which parts of the process are losing people, and provides us a good guide on where to focus our attention.  Sometimes a technical problem will be the root cause and sometimes it will just be that a page was confusing.  Every now and then we get a curve ball.



:EXTENDED:



<img src="http://metajack.files.wordpress.com/2007/03/actpercent.png" alt="actpercent.png" />

Each day we produce lots of graphs similar to this one.  This particular graph shows the percentage of people who successfully activated their <a href="http://www.chesspark.com/">Chesspark</a> accounts by clicking a link in an email we send out upon account creation.  Everything looks normal until the last data point where it appears to crash.

We could find no bugs which would cause such a drop in activations and none of the signup pages had changed in this period.  We were stumped (and about to chalk it up to randomness) until my wife suggested that perhaps some major email server was having issues.

We did a quick couple of queries to figure out how many of our users were from various email domains and discovered that more than half the accounts were from Hotmail, Yahoo, or Gmail.  It was easy enough to redo the plot restricted to these domains, and the one for Yahoo is shown below.

<img src="http://metajack.files.wordpress.com/2007/03/yahoopercent.png" alt="yahoopercent.png" />

It has the same drop off at the last point, so it seems we've found the culprit.  It was easy enough to check the numbers to see if this accounted for most of the activation loss, and it did.  It turns out that Yahoo mail was having major technical problems that weekend.
