---
layout: post
title: Prosody Gets Cross-Domain BOSH Support
tags: [jabber, xmpp, bosh, prosody]
time: "20:53"
extended: ":EXTENDED:"
---

Matthew Wild just added Cross-Origin Resource Sharing (CORS) support
to [Prosody](http://prosody.im). He discusses the implementation in
the [Prosody
blog](http://blog.prosody.im/proxy-less-bosh-with-prosody/). This
makes the third BOSH connection manager with CORS support in three
days. What a promising trend!

Unlike my patches, Matthew has made the support disabled by default,
but it also offers the complete fine grained control over access that
CORS offers. I'm not sure why this is needed, since outside of a web
browser, there is no access control. I can't think of a situation
where this would be useful off the top of my head. If someone comes
up with a good use case, I may revise my
[ejabberd](http://www.ejabberd.im) and
[Punjab](http://code.stanziq.com/punjab) patches to add similar
support.

Hopefully we'll see an eager Java hacker add similar support to
[Openfire](http://www.igniterealtime.org/projects/openfire/) and
[Tigase](http://www.tigase.org/), and then all major BOSH
implementations would have support.
