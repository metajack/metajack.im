---
layout: post
title: Do You Know What Your Database is Doing?
tags: [chesspark, code, database, django, postgresql, python, sql, twisted]
time: "21:20"
extended: ":EXTENDED:"
---

There are so many different web frameworks these days that it is hard to keep count.  Do you ever wonder exactly how they are accessing your data?  Even if you write your own SQL, do you know how often it executes?  In order to investigate performance issues at <a href="http://www.chesspark.com/">Chesspark</a>, I wrote a query analyzer to answer these questions.   The analyzer looks at all queries and their execution times.   It generates a report of which queries are executed most often, which queries have the longest average duration, and which queries consume the most database time.  The results were quite surprising for us.  For example, we found that one of our simplest apps was generating too many queries by several orders of magnitude (a good candidate for caching!) and that Django and Twisted, two frameworks whose database layers we make heavy use of, had so much overhead that it was frightening.



:EXTENDED:

The analyzer is quite simple.  It groups queries by their generic type (by removing the literals) and keeps track of how many times a given query type was executed and how long it took.  It then uses this data to generate reports.  You can find the analyzer source code below along with some brief documentation.  It is written in Python for PostgreSQL log files, but the ideas are universally applicable to any SQL database which can generate the log data.

Here is an exerpt from a report:
<blockquote>
<pre>TOTAL QUERIES: 348 generics from 4719056 total
TOTAL DB PIDS: 32018
TOTAL DB TIME: 747.62m</pre>
<pre>TOP 25 QUERIES BY FREQUENCY:</pre>
<pre>...</pre>
<pre>80281: 0.45ms: 1.70%: 0.08%: SET TIME ZONE ?
80307: 0.24ms: 1.70%: 0.04%: SHOW client_encoding
80307: 0.07ms: 1.70%: 0.01%: SHOW default_transaction_isolation
80307: 0.25ms: 1.70%: 0.04%: SET DATESTYLE TO ?
204854: 0.36ms: 4.34%: 0.17%: SELECT member_title.title_id AS title_id ...</pre>
<pre>...</pre>
</blockquote>
The first line says that we had 348 types of queries out of over 4 million actual queries.   These came from 32,018 process ids and the database used 747 minutes of cputime to execute these (unfortunately the script doesn't help you out by telling you the wall time elapsed from the log file yet).  The report lines give data in this format: "number of queries: avg. duration: % by frequency: % by total duration: generic query".
<p align="left">So we can see from the above data that approximately 6% overhead is coming from somewhere.  We shouldn't really need 4 times 80,000 database configuration statements, even if it isn't using much of database time.  We can also see that we're doing a simple SELECT over 200,000 times, which probably means we should be caching something in the application.</p>
The next report section is generic queries by average query duration.  I find that this section isn't very useful as there are many singleton queries (usually ones that have been run manually) that consume a lot of database time.  I need to do some work to strip out those kinds of things before this section is worthwhile, but your experience may be better.

The last section is generic queries sorted by total database time used.  This is a list of the slowest queries.  Before we started analyzing queries and optimizing them, this section was filled with queries that were just missing a simple index.  Now that we've got the indexes all set up, this section is mostly full of INSERT and DELETE statements, which are expected to be slow.

We have been using this analyzer for months now and have made many discoveries about how our application is using the database.  We've easily made a few orders of magnitude improvement.  Generally improvements have fallen into a couple categories:
<ul>
	<li><strong>Eliminating application or framework overhead. </strong>Early on we noticed that Django doesn't reuse database connections and that its startup queries are quite expensive.  For example, all the overhead queries I discussed earlier are from Django.  The stock Django source is actually worse than this, as we've made several improvements in our local branch (which we've been trying to push upstream).  Also, Django overused transactions for single queries, so every database statement was actually four commands: BEGIN, SET TRANSACTION ISOLATION LEVEL READ COMMITTED, (normal statement), END/COMMIT.  We found this same problem in Twisted's adbapi which we also use heavily.  This alone got us 2-3x performance improvement all by itself.  I'm sure that Rails and other frameworks have some of these problems as well; I'm certainly not trying to pick on Django or Twisted.</li>
	<li><strong>Adding appropriate index to speed up slow queries. </strong>Using the list of the queries that dominated database time, it's easy (in PostgreSQL anyway) to use EXPLAIN to figure out what is taking up a lot of time.  Many times we found that indexing was the easy solution.  However, we did find that Django used ILIKE for case insensitive matching instead of LOWER(col) = LOWER(?), which can't be indexed.  We patched this in our local tree and also sent it upstream.</li>
	<li><strong>Cache data that you are fetching too often. </strong>When we find SELECT queries dominating the frequency report we know it is time to start caching some data.  Often it is easiest to write the code in the simplest way while it is in flux and then come back later and optimize it.  Doing this kind of query analysis lets us know exactly where our optimization efforts are best spent.</li>
</ul>
All of these things are common sense, of course.  The issue is knowing exactly which queries are causing the problem.  Once we find a problem query or group of queries, it is usually pretty easy to fix, and then it's wash, rinse, and repeat.

The code is below for anyone who is interested.  I'd love to hear feedback on it as well as what you discover about other web and database frameworks with it.  Enjoy!

<a href="http://people.chesspark.com/~jack/analyzer.zip">Download analyzer.zip here.</a>

Update 05-15-2008: Fixed broken link to analyzer.zip.
