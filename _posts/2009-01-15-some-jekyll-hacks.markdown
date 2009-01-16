---
layout: post
title: Some Jekyll Hacks
tags: [jekyll, ruby, code]
time: "21:20"
extended: ":EXTENDED:"
---

While switching my blog to
[Jekyll](http://github.com/mojombo/jekyll/tree/master) I made several
improvements and fixes to the code.  You can find these in [my Jekyll
fork](http://github.com/metajack/jekyll/tree/master) on
[GitHub](http://github.com).

* I replaced the Maruku library with BlueCloth since Maruku was
  refusing to parse some of my perfectly valid Markdown.  I should
  probably make this configurable; the code is written so that it can
  be, there is just nowhere to configure it.
* I changed the post object to include arbitrary YAML properties
  instead of just a few hard coded ones.  This allows tags and
  categories and other interesting things to get passed around and
  into the templates.
* I added a special YAML property to allow arbitrary script output to
  be included in a template.  I use this to generate the tag cloud you
  see on the left.  This makes Jekyll able to do really neat things.
* I modified all the URLs to full paths instead of files with
  extensions.  For example, `/2009/01/15/some-jekyll-hacks/` instead
  of `/2009/01/15/some-jekyll-hacks.html`.
* I added extended body support and time handling, for those of us who
  write long posts or multiple posts per day.
* I added a new template filter, `html_truncatewords` which you can
  use to make summaries of HTML text without worrying about the markup
  getting messed up.
* I added archive generation support.
* I added some basic Emacs support.

In addition to Jekyll hacks, I also wrote a converter for
[MovableType](http://movabletype.org) which you can also find [on
GitHub](http://github.com/metajack/mt2jekyll/tree/master).  In that
same project I have also included code to convert MovableType comments
to [Disqus](http://disqus.com) comments.

If you want to see what this all looks like, I have a [snapshot of my
blog](http://github.com/metajack/metajack.im/tree/master) on GitHub as well.
