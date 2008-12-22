---
layout: post
title: 5 Reasons To Love Django
tags: [code, django, python]
time: "09:51"
extended: ":EXTENDED:"
---

Django is one of the best web frameworks out there.  Although <a href="http://metajack.im/2008/06/11/the-problem-with-django/">no project is perfect</a>, any project wanting to best Django has a tough act to follow.  Here's why:
<ol>
	<li><strong>Django is a full stack</strong>.  This means that while it is possible to replace bits and pieces with other bits and pieces, it provides everything you need by default.  Each of the provided pieces is well integrated and works.  For example, the auto-generated admin interface is quite a time saver, and is possible only because the forms, templating, authentication, and ORM systems are all working nicely together.</li>
	<li><strong>Django is trivial to extend</strong>.  When you are working on a project and you come up with some crazy idea, you can make it real in minutes. <a href="http://www.djangoproject.com/documentation/middleware/">Django Middleware</a> allows you to extend how requests are handled.  Want to add an HTTP response header that tells you how long it took Django to process the page? <a href="http://www.djangosnippets.org/snippets/797/">Done</a>.  Middleware also allows you to modify content.  This can be useful for <a href="http://www.djangosnippets.org/snippets/161/">database debugging</a>.  Want to add templating commands?  <a href="http://www.djangoproject.com/documentation/templates_python/#writing-custom-template-tags">Template tags</a> to the rescue.  The list goes on and on.</li>
	<li><strong>Django is written in Python</strong>.  Python is really easy to learn, and regardless of what you hear, the significant whitespace makes code enjoyable to read.  How easy?  I hired someone who had never used Python or Django, and they wrote the <a href="http://www.chesspark.com/forum/">Chesspark forum</a> in about a week.  Other benefits of Python abound.  Want a certain view to be locked down?  Python's decorators will help; just add '@login_required' above the view definintion and you're done.</li>
	<li><strong>Django has a large and helpful community of users</strong>. Got some code snippets to share?  Try <a href="http://www.djangosnippets.org/">Django snippets</a>.  Have a question?  Ask on the <a href="http://groups-beta.google.com/group/django-users">mailing list</a> or in the <a href="irc://irc.freenode.net/django">chat room</a>.  Look at what those users create at <a href="http://www.djangosites.org/">djangosites</a>.  They also love to write about Django in <a href="http://www.djangoproject.com/community/">their blogs</a>.</li>
	<li><strong>Django documentation is excellent</strong>.  It amazes me how good the documentation is.  It's not just "most open source projects documentation sucks so this is infinitely better" good; it is <em>really</em> good.  Anytime I have some weird question, it's almost surely mentioned in the documentation along with an example.  Just <a href="http://www.djangoproject.com/documentation/">look at it</a>.  It's huge.  This documentation puts many commercial projects to shame, and is something that other open source projects should aspire to.  It makes the project accessible to many that probably gave up in frustration using other web frameworks.</li>
</ol>
If you haven't looked at Django yet, the <a href="http://www.djangoproject.com/documentation/overview/">overview</a> is a great place to get a feel for it.  I highly encourage you to take a peek and see what you're missing.

The best part of it all is, Django is not even finished!  The 0.96 version is very stable and in wide use, but those guys have not been resting on their laurels.  The 1.0 version has a <a href="http://groups.google.com/group/django-developers/browse_thread/thread/5ce124e7526dad">tentative date</a> of September 2008, with alpha and beta releases to start in about a month.  A lot of the bits and pieces are getting significantly better.  You don't even have to wait for them if you are curious since most of them are completed (or nearly so) in <a href="http://code.djangoproject.com/">the repository</a>.

:EXTENDED:


