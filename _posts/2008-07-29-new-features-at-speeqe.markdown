---
layout: post
title: New Features At Speeqe
tags: [group chat, jabber, muc, speeqe, xmpp]
time: "08:58"
extended: ":EXTENDED:"
---

We just <a href="http://blog.speeqe.com/2008/07/29/early-access-and-new-features/">released some new features</a> for <a href="http://www.speeqe.com/">Speeqe</a>, a simple group chat application for the Web.  This release includes private room messages, external MUC support, early access for interested people to host their own rooms, external Jabber authentication, and image inlining.

Please check it out.  We're looking for people interested in starting their own Speeqe rooms.  If you'd like your own space, just <a href="mailto:help@speeqe.com">email us</a>, and we'll make it happen.

<strong>Jabber Bugs</strong>

We use negative presence priority to keep the Speeqe client from stealing your normal private messages.  Unfortunately, if you set a negative priority on your resource, both Jabberd 2.x and the Google Talk server stop sending you presence of any kind.  This means that you never get the presence status of people in a chat room, not even intiially.  This is a pretty big bug for us, and if anyone has any suggestions on workarounds while we try and work with Google and smoku to get it resolved we'd love to hear them.

<strong>External MUCs</strong>

As we demoed in Portland at the <a href="http://www.xmpp.org/summit/summit5.shtml">5th XMPP Summit</a>, you can now use Speeqe with external MUC rooms.  Just substitute the address of the room in this URL: http://www.speeqe.com/room/ADDRESS/ .

After you enter a room for the first time, you can log in using any federated Jabber account (including Gmail).  Once you do this once, any room you join will reuse the same information.

<strong>UI Love</strong>

The UI is a work in progress.  We know some things are currently a bit ugly, and we're working hard to address them.  In particular this release was more about technical features than UI design.  The next release should have more UI design elements.

Everything in the room is themeable.  In a release or two, we will open up the theme creation tools to everyone.  Themes are just HTML pages, and Speeqe uses CSS selectors to decide where to fill in content.  It can already do quite a lot - see the <a href="http://www.speeqe.com/">demo themes</a> for an example.

:EXTENDED:


