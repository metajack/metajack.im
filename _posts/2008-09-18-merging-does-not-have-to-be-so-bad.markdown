---
layout: post
title: Merging Does Not Have To Be So Bad
tags: [combinator, python, subversion, svnmerge, versioncontrol]
time: "15:30"
extended: ":EXTENDED:"
---

[Subversion](http://subversion.tigris.org) fixed a lot of pain points of CVS, but merging was not one of them.  When doing [branched based development](http://www.divmod.org/trac/wiki/UltimateQualityDevelopmentSystem), you perform lots of merges.  Doing this manually in Subversion requires searching for revision numbers for simple tasks like merging a branch back to trunk or merging an updated trunk into a branch.  For anything more complicated, it becomes a real mess.  I'm unsure why Subversion remains so low level in this regard while tools like [bzr](http://bazaar-vcs.org) and [git](http://git.or.cz) make merges easy.  Luckily, third parties have provided tools to ease the pain for those projects that choose to use Subversion.


:EXTENDED:

## Divmod's Combinator

[Divmod's](http://divmod.org) [Combinator](http://divmod.org/trac/wiki/DivmodCombinator) is a Python tool that manages branches for projects.  It also manages `PYTHONPATH` for those projects as well.  

Combinator adds `mkbranch`, `chbranch`, and `whbranch` commands which create a branche, select a branch, and query the active branch for a project.  For merging, you use `unbranch`.  For example, `chbranch chesspark website-typos-1234` would change the active branch for the chesspark project to `branches/website-typos-1234` (relative to the project root).  After you make some changes, you merge to trunk with `unbranch chesspark` and commit from the trunk working directory.

### The Good

* Working with branches is pretty easy, and switching back and forth among branches is also easy.
* `PYTHONPATH` is kept pointing to the active branch, reducing confusion about which version of the code is running.
* Merging from a branch to trunk is very easy; just type `unbranch <project>` when the active branch is not trunk.
* Creating a branch is handled for you; you do not have to run `svn copy foo bar` yourself.

### The Bad

* When `/branches` gets large, Combinator is slow.  This can be fixed by pruning old branches.
* Combinator enforces a particular repository and working directory structure.  Each project must have a `/trunk`, `/tags`, and `/branches` layout, and the working directories look like:
<code>
<pre>
project/
project/trunk
project/trunk/...
project/branches/
project/branches/website-typos-1234/
project/branches/website-typos-1234/...
project/branches/other-branch-2345/
project/branches/other-branch-2345/...
</pre>
</code>
Each branched directory must be a copy from `/trunk`.
* Combinator manipulates `PYTHONPATH`.  It can be good, but it's also doing more than just helping you manage branches.
* It fails horribly if you put any symlinks in `/trunk`.  Probably won't affect you, but this bites me all the time.
* Managing arbitrary trees is not possible.  For example, we keep local modifications to external projects in a `/locals` tree.  We still have to do merges for these by hand; Combinator can't help us.  It probably could if we were willy to play games with the path names.

### The Verdict

Combinator does its job well.  Some of the error messages can be opaque at times, but if you are willing to live with its path requirements, it is excellent at what it does.  Several of us have used Combinator for a few months now for [Chesspark](http://www.chesspark.com) development, and aside from the symlinks and `/locals` management, we haven't had any problems.

The tool, warts and all, made branch based development easy enough in Subversion that we actually started doing it.  Our code is much better for it.

## svnmerge.py

[svnmerge](http://www.orcaware.com/svn/wiki/Svnmerge.py) takes a slightly different tactic.  As its file extension implies, it is a self-contained python script.  Like Combinator, it makes branch based development easy, but unlike Combinator it can cherry pick patches and handle repeated merges from trunk to a branch.

You use `svnmerge.py init` to initialize a branch for tracking.  svnmerge uses a few special revision properties to store merge information; this helps it keep track of which revisions are already merged.  It never commits for you, but it does provide a default commit message that you can use if you choose.  For example, to initialize a branch for tracking and merge in the latest changes from trunk:
<code>
<pre>
cd /path/to/branch
svnmerge.py init
svn commit -F svnmerge-commit-message.txt
svnmerge.py merge
svn commit -F svnmerge-commit-message.txt
</pre>
</code>

You can cherry pick revisions to merge by specifying them as an option to the merge command.

Merging the other way is also easy.  You just initialize trunk for tracking a specific branch, then merge from that branch.  The only difference from the above is that `-S <branch>` is used to specify which branch to work with.

### The Good

* Advanced merging functionality is supported.  You can merge multiple times without worrying you will duplicate a revision, and you can cherry pick revisions to merge.
* svnmerge can also merge an updated trunk into a branch.  Combinator, in contrast, usually needs a new branch to be created for this.
* There is very little to install; just drop the script into your `PATH`.
* No directory structure is enforced, except that branches must be copies of `/trunk`.  You can work using `svn switch` instead of storing all the branches in the file system at once.
* No repository structure is enforced.  It knows where the source of the copy came from and doesn't depend on the repository layout.
* The default commit messages are reasonable and save tons of typing.  When you merge a branch to trunk, it includes a change log with the commit messages from each merged revision in the suggested message.
* It does no fancy stuff with `PYTHONPATH`.

### The Bad

* It uses special revision properties to track merge history.  This means that you need an extra commit or two at the start or end of the branching process to update this information.  The ability to have this merge history usable by others is probably worth the cost.
* I really dislike the `.py` extension.  Thankfully, it's trivial to rename the script.

### The Verdict

It's simple and easy.  It supports advanced functionality that Combinator does not.  It makes merge history available to everyone at the cost of an extra commit and some revision properties.  It seems to be the winner.

I have not had as much experience with svnmerge as with Combinator, but I've started using it for [Strophe](http://code.stanziq.com/strophe) and [Punjab](http://code.stanziq.com/punjab).  So far, I'm very happy.
