---
layout: post
title: Web Hooks Notifications For Git
tags: [code, git, python]
time: "19:55"
extended: ":EXTENDED:"
---

A few days ago I posted about my [commitbot](http://github.com/metajack/commitbot/tree/master) code which notifies XMPP multi-user chat rooms about [Git](http://git.or.cz) repository changes.  The script used [GitHub's](http://github.com) [Web hook API](http://github.com/guides/post-receive-hooks).  For those of you not using GitHub, I've also written a Web hook notifier post-receive hook script.

You can find the Python code in my [notify-webhook](http://github.com/metajack/notify-webhook/tree/master) GitHub repository.  It will allow any Git repository to use Web hook enabled services, and it follows the GitHub API as closely as possible.  

For example, you could use notify-webhook along with any of the service integration scripts that GitHub provides in its [github-services](http://github.com/github/github-services/tree/master) to provide things like XMPP, IRC, Campfire, or Twitter integration for arbitrary Git repositories, not just those hosted on GitHub.

:EXTENDED:


