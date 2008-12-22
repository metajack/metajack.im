---
layout: post
title: Merging With Subversion No Longer Painful
tags: [code, subversion, versioncontrol]
time: "10:10"
extended: ":EXTENDED:"
---

Last week I [wrote](http://metajack.im/2008/09/18/merging-does-not-have-to-be-so-bad/) about the various third party tools one can use to make branch based development easy with Subversion.  One of the comments to that post mentioned new merging features in Subversion 1.5, and I quickly checked them out.  They solve the same issues as [Combinator](http://divmod.org/trac/wiki/DivmodCombinator) and [svnmerge.py](http://www.orcaware.com/svn/wiki/Svnmerge.py) and more.

:EXTENDED:

Ben Collins-Sussman has [written up the basics](http://blog.red-bean.com/sussman/?p=92) of how the new merging features work.  This is well worth a read.  More detailed information can be found in the latest version of the [Subversion book](http://svnbook.red-bean.com/) in the [chapter on branching and merging](http://svnbook.red-bean.com/en/1.5/svn.branchmerge.html).

Subversion adds merge history information into the tree by using a special revision property.  This is a lot like svnmerge.py's solution, and, in fact, there is [a script](http://svn.collab.net/repos/svn/trunk/contrib/client-side/svnmerge/svnmerge-migrate-history.py) to convert repositories that used svnmerge.py to the new format.

The only real caveat is that both the client and the server must be running Subversion 1.5.x, and to prevent merges without history from happening, one must also prevent pre-1.5.x clients from committing.  This is a small price to pay for this functionality, and will become ever smaller as everyone upgrades over time.

