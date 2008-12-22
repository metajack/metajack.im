---
layout: post
title: The Problem With Django
tags: [code, django, python]
time: "08:30"
extended: ":EXTENDED:"
---

<a href="http://www.technobabble.dk/2008/jun/07/django-importance-releases/">Christian writes</a> about his frustration with Django's release process.  There has not been a new release of <a href="http://www.djangoproject.com/">Django</a> for over a year, and the prevailing advice is to use trunk, the latest development code.  I sympathize with him.

We run Django 0.96 at <a href="http://www.chesspark.com/">Chesspark</a> with plenty of patches.  We have our <a href="http://metajack.im/2007/08/02/django-patches-for-efficient-database-access/">database patches</a> that fix many inefficiencies in stock Django.  All but one of these patches are still, a year later, not integrated upstream.  Most of the patches have been accepted but are just sitting there.  Recently we added a backport of the <a href="http://code.djangoproject.com/ticket/2070">streaming file uploads patch</a>, which has also not been integrated into trunk.

<strong>No Releases Leads To Slower Development</strong>

Christian also notes that <a href="http://code.djangoproject.com/ticket/3639">developers are reluctant to commit to trunk</a> now for fear of breaking things for all the people that must depend on trunk to be stable.  Perhaps this is why contributing users like us have to wait over a year and continually fight to have our bugs remain open and our issues addressed.

There is no perfect software, and the whole point of web facing software is that it can be quickly iterated.  I understand that Django would like to get to the magic 1.0 release, but not making any interim releases is just making the whole process take longer, I fear.

<strong>Django Needs Better Maintainership</strong>

The bar is high in open source projects for good maintainership.  Just look at the Linux kernel for an example of this.  Keeping up with the community is a hard job, and that's why projects delegate responsibility to the community.

Here are my suggestions for improving things:
<ul>
	<li>Stop waiting for perfect bug fixes and let improvements be incremental.  If the patch can potentially benefit other pieces of code then open new bugs for this and get the patch into the tree.  Improvement for some people is better than improvement for none.</li>
	<li>Stop waiting for 1.0 and do regular releases.  Some of these releases may break things compared to previous releases.  This is fine.  We all know that Django is a young project and that it is in heavy development.  I would rather that the upgrade pain be a known quantity instead of in constant motion.</li>
	<li>Take care of your community. Communicate why bugs aren't moving forward.  People who submit patches are relatively rare, and the project needs to educate these people so that future patches are better, and also treat them nicely so they don't get frustrated.  I spent a lot of time figuring out why Django was slow, fixing it, preparing patches, and working to get these patches applied.  Why must I continually fight people to keep the bug open and progressing?  This is not very encouraging.</li>
	<li>Delegate responsibility if you don't have the knowledge.  I know several people who can't use Django because it doesn't support MS SQL Server.  People are working to address this problem, but are forced to work outside the core project since Django removed all the MSSQL stuff for lack of a maintainer.  Surely if there are two seperate projects for MSSQL on Google Code then there is someone interested in maintaining this part of DJango, even if that maintenance is in form of a rewrite.</li>
</ul>
<strong>Long Live Django</strong>

I really hope that Django can overcome these issues and be one of the projects that is so well run that other projects use it for inspiration.  It has a lot of utility and promise even at this early stage, which is why I have used it on three different websites and am building new ones on top of Django as well.  I also recommend Django to others.

These issues need to be addressed, and I hope the Django team does so.  It was a little embarassing to recommend Django to people and have those people come back to me with "Django doesn't care about XYZ".  Surely they were wrong, I thought.  Looking into the issue, I can see why they think this.  When a project closes the door on useful contributions (like MS SQL support), it is hard to take away any other message.

Please keep making Django better.  We'll be here trying to help.

<strong>UPDATE 06/12:</strong> Please read the counterpart post as well: <a href="http://metajack.im/2008/06/12/5-reasons-to-love-django/">5 Reasons To Love Django</a>.

:EXTENDED:


