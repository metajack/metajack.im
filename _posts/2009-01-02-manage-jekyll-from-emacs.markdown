---
layout: post
title: Manage Jekyll From Emacs
tags: [emacs, jekyll, blog, code]
time: "20:46"
extended: ":EXTENDED:"
---

I recently switched this blog over to
[Jekyll](http://github.com/mojombo/jekyll/tree/master).  Jekyll is a
static blog generator that can be used to manage a blog from source
control instead of from a silly Web app.  In my case, this blog lives
in [Git](http://git.or.cz) and whenever I push new commits it
regenerates the site.

Today I spent a little time automating some common actions in
[Emacs](http://www.gnu.org/software/emacs/) for working with Jekyll
blogs.  You can find `jekyll.el` in [my Jekyll branch on
GitHub](http://github.com/metajack/jekyll/tree/master/emacs/jekyll.el).

Here's what it does:

* `C-c b n` - Create a new draft post.
* `C-c b P` - Publish a draft.
* `C-c b d` - List all drafts.
* `C-c b p` - List all posts.

I'm quite happy with it, and it has been fun exploring [Emacs
Lisp](http://en.wikipedia.org/wiki/Emacs_Lisp).
