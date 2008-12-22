---
layout: post
title: code.stanziq.com Switching to Git
tags: [code, git, palaver, punjab, speeqe, stanziq, strophe]
time: "22:39"
extended: ":EXTENDED:"
---

My team and I have been talking about switching to distributed version control for some time now.  We've had a lot of great contributions from the community, but we've felt the barriers to participation could have been much lower.  After investigating several different systems, we finally settled on [Git](http://git.or.cz).

I'm still in the process of converting all the [Subversion](http://subversion.tigris.org) history, but we've already got our internal projects up and running on the new system.  The only other change is that Web repository browsing will be done via [cgit](http://hjemli.net/git/cgit/) instead of [Trac's](http://trac.edgewall.com) internal browser.  cgit turns out to be much, much faster than the git plugin for Trac, or Trac's Subversion browser, and it looks pretty nice to boot.

At some point I'd like to write up a list of pros and cons of the various distributed version control systems that we found during our research.  Most of the reviews we found were from people who compared them only to Subversion and not to each other, and sites like [whygitisbetterthanx.com](http://whygitisbetterthanx.com) are a little one sided.

:EXTENDED:


