---
layout: post
title: "Trending Topics: The Good and the Bad"
tags: [trending]
time: "14:22"
extended: ":EXTENDED:"
---

Trending topics are becoming a big deal, but they aren't without their
problems. It seems like exactly the kind of tool that should help
people solve their issues with information overload, but so far,
current implementations are not up to this task. This has led some to
prematurely declare them useless. I think they show much promise and
that it's too early to judge.

It's probably best to start with the problem statement. Trending
topics are a distillation of the popular things in some data
set, usually during a certain time frame. For example, Google
publishes their [Year-End Zeitgeist
reports](http://www.google.com/press/zeitgeist/yearend.html) with the
topics that were the fastest rising or falling through an entire
year. On the other end of the spectrum, my company
[Collecta](http://collecta.com) and sites like Twitter try and distill
trends on much shorter timescales.

## The Importance of Time

[Clive
Thompson](http://www.collisiondetection.net/mt/archives/2010/01/the_problem_wit.php)
lamented that there were no insights to be had in Twitter's top trends
of 2009, which included topics like Tiger Woods and Michael Jackson:

> These subjects are all screamingly obvious, each having been long
> ago chewed into a tasteless cud by the 24-hour news cycle.

This is, of course, absolutely true. This is also the way it is
supposed to work. When you ask the question "what were the most
important trends of 2009?", you are going to get an answer that
includes mostly stuff that you remember. Once something is big enough
to be a trend in the context of an entire year on a large service, it
probably received lots of coverage in mainstream sources and probably
showed up in pop culture references on TV.

The problem is that this statement is not true when you look at these
trends in the context of time. When Michael Jackson died, social media
sites received millions of updates and comments as people expressed
their feelings. This immediately made it a trending topic. This was
not blindingly obvious before it happened.

There are now lots of stories that break on social media sites like
Twitter before the mainstream press covers them. Some of these events
trend before the general public is aware of them, and in these cases,
the trending topics fulfill some of their potential.

Without the context of time, everyone should know the
trending topics; that's why they trended in the first place.

## Geo-centrism

It's no secret that mainstream news in the US is very domestically
focused. A news story about a celebrity is likely to displace real
news from elsewhere in the world. The same situation exists in most
countries, I imagine.

Fortunately, the Internet is a global community, and this can be seen
in trend data. For example, Iran was trending on social media sites
before it got much coverage in mainstream press.

For an Iranian, or someone with Iranian friends and family, news of
Iran is likely to be extremely important. These kind of trends show up
very quickly on the Internet, which has participants from the far
corners of the Earth.

If you look at the trend data for a site like Twitter or Google and
compare that data to US magazines and newspapers, I think the
difference will be one of geography. Many topics will surely overlap,
as they are of general interest, but where the topics are disjoint
will reveal local bias.

## Select Data Sets

I think trending shines most brightly when it can be arbitrarily
applied to various data sets. The fact that Iran is a trending topic
is interesting, but if I really want to understand what's going on, I
want to know what is trending *within* that topic.

Similarly, I may want to see what is trending among my friends or
among people within my city. Or to use an example close to my own
work, you might want to know what is trending related to arbitrary
keywords.

This eliminates a lot of the triviality of current trending. I
wouldn't expect to see a trending topics list for 2009 among my
friends to look very much like the global one. It's likely to contain
a lot of technical topics and be less focused on entertainment.

Applying this to arbitrary keywords will yield some interesting
surprises. What were the trending topics for your company or your
product? Even if you've read every post people have written about the
subject, you may fail to see the general trend.

## Naive Algorithms

The main flaw with current trending topics implementations are that
they are fairly simply algorithms that are easily gamed. These
algorithms are the low hanging fruit; they tend to do a reasonable job
if you finesse them, but they aren't sophisticated.

[Bradford Cross](http://measuringmeasures.blogspot.com) recently wrote
an [awesome
piece](http://measuringmeasures.blogspot.com/2010/01/beyond-pagerank-learning-with-content.html)
on the current state of various AI techniques. One of the parts that
resonated with me was "Pandora is not the state of the art." It may
seem like magic, but behind the scenes the learning algorithms are
shallow and not scalable.

We are not up to the "state of the art" in trending yet,
either. Luckily, unlike Pandora, most people think the current
trending implementations are not great. This means companies will be
pressured by users to investing in the research and design necessary
to improve these systems.

I think it's much too early to write off trending topics as
useless. There are some real promising features that are on offer
including faster detection, removing local bias, and applying trends
to arbitrary data sets. However, it's going to take some real work to
get where people expect it to be.
