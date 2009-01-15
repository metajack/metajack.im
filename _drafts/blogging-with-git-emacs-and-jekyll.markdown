---
layout: post
title: Blogging with Git, Emacs, and Jekyll
tags: [blog, git, emacs, jekyll, ruby]
time: "22:22"
extended: ":EXTENDED:"
---

A few months back I switched this blog to
[Jekyll](http://github.com/mojombo/jekyll/tree/master).  Jekyll is a
static blog generator; it transforms a directory of input files into
another directory of files suitable for a blog.  The management of the
blog is handled by standard, familiar tools like creating and renaming
files, the text editor of your choice, and version control.  Jekyll
combined with Git and Emacs has made blogging feel very natural to me.

## What is WordPress, Really?

WordPress and other blogging systems are simplified content management
systems.  Many of the features they provide relate to a blog's minimal
need for dynamic content.  The front page needs to change as new
things are added, and each post must change as comments, trackbacks,
and edits are made.

Along they way they often made it harder to just write.  While they
keep providing more and more sophisticated text editing capabilities,
most of us who write or code are quite comfortable in our own
editors.  No matter how good the text editing widgets become, they are
not Emacs or vim or TextMate.

Blogs have simple APIs for using external products, but even these
products are often not great text editors.  When the real text editors
have added the ability to speak these APIs, the functionality feels
bolted on and clunky.  The reason is that we are used to interacting
with documents in a file system, and the current blogging APIs are
much less elegant than the familiar, simple API of a file system.

Managing documents is something nearly everyone using a computer has
gotten quite good at, and the tool support for this is immense.  We
have automatic indexing systems like Spotlight, powerful search tools
like `grep`, and history tracking and analysis tools like
[Git](http://git.or.cz).

WordPress and others would do well to concentrate on the areas where
blogging software is really needed and expose the document management
part via [WebDAV](http://www.webdav.org/) or something similar.  In
the end, WordPress is a transformation layer to take some set of
documents and turn it into a blog as well as a system to provide
commenting, trackbacks, and search.

## The Post-WordPress World

Let's look at the key areas where blogging software is necessary.  We
have transformation of content, interaction with content (commenting
and such features), and search.  In all these areas superior, domain
specific tools have emerged.

Search is dominated by Google, but there are other services that can
also be used.  I have been really underwhelmed by the search
capabilities found in self-hosted blogs, but Google's site search is
really good.

Interaction services started appearing as spam became a problem for
blog comments.  Now we have full featured services like
[IntenseDebate](http://intensedebate.com/) and
[Disqus](http://disqus.com/) which provide excellent interaction
features like email integration, comment aggregation, moderation and
filtering, and portable identity.

Now we come to transformation of content, which turns out to be the
only missing piece that on really needs.

## Jekyll Generates Blogs

Jekyll fills this last piece of the blogging feature puzzle.  It takes
a tree of documents and transforms that into a blog.

At a basic level, Jekyll goes through the directory tree and
translates files from a variety of formats like
[Markdown](http://daringfireball.net/projects/markdown/) and
[Textile](http://www.textism.com/tools/textile/) into HTML.  Each file
can contain a small [YAML](http://www.yaml.org) header with metadata.
These metadata blocks tell Jekyll which template to use during
rendering and define the title and other properties of the document.

A few directories in Jekyll are special.  `_posts` contains all the
blog posts, with each post being named in a common format such as
`2009-01-14-blogging-with-git-emacs-and-jekyll.markdown`.  `_drafts`
contains documents that are ignored by Jekyll.  `_layouts` contains
rendering templates that are used during the transformation process.

My own templates use Disqus for comments and Google for search, but it
is easy to mix and match the services you want in your own templates.

The resulting generated site has a standard URL structure of
`/2009/01/14/blogging-with-git-emacs-and-jekyll/` and the front page
and RSS or Atom feeds are just simple templates that loop over the
latest group of posts.

## Managing and Publishing with Jekyll

You can use Jekyll by hand, but it is meant to be used alongside a
version control system.  Whenever you commit or push to the
repository, it runs the `jekyll` command to generate the blog from the
latest data.

Git is a popular choice here, but
[Subversion](http://subversion.tigris.org) or
[Bazaar](http://bazaar-vcs.org) would also do a fine job.  One thing I
like about Git is that I can set up a remote on my main machine to my
Eee laptop, and a corresponding remote in the other direction.  Both
machines have the *origin* remote set to my blog's server.  This means
I can easily push and pull the blog around between machines and I
always have access to the entire blog no matter what machine I'm on.

I also wrote [some Emacs
glue](http://metajack.im/2009/01/02/manage-jekyll-from-emacs/) to help
automate my own blogging workflow.  I start new drafts with `C-c b n`
and then move drafts to the `_posts` folder with `C-c b P`.  I can
also easily access the list of drafts or posts when I'm searching for
something I've previously written.  This kind of glue is easy to write
in any language because it leverages the familiar platform of the file
system.

## Why I Love This System

Now that I've been using this system for several weeks, I'm really
loving it.

* I'm using the same tools I always use for the rest of my work to
  write and manage my writing.
* I always have access to my entire blog, which is awesome when I am
  crafting posts on plane rides and need to reference some previous
  content.
* If I find some manual thing in my workflow, I can use any number of
  common tools to automate or customize it.  Everything is just text
  and files.
* Comments are now just email threads to me, which means I don't have
  to use some clunky interface.  Once again, I can use tools which are
  already part of my daily work habits.

If you've ever thought about blogging, or blogging more, but didn't
want to mess around with blogging clients, Web interfaces, or
installing or maintaining blogging software, you should give Jekyll a try.
