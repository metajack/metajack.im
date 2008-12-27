---
layout: post
title: Speeqe Is Open To All
tags: [code, group chat, jabber, muc, speeqe, xmpp]
time: "11:40"
extended: ":EXTENDED:"
---

[Speeqe](http://www.speeqe.com) is now officially an open source project.  [Nathan Zorn](http://www.unclenaynay.com/) has led the project from the outset and has been working hard to prepare the first release.  You can find the Speeqe code at the [Speeqe project site](http://code.stanziq.com/speeqe).  In addition, we've opened up [Speeqe.com](http://www.speeqe.com) so that anyone can create accounts and rooms.  There is still much work to be done, but we believe that with your help we can make the best group chat clients and services on the Web.



:EXTENDED:

## A Bit About The Code

The code is a mixture of Python, JavaScript, and a tiny bit of Erlang.  Don't let this frighten you, as each piece is fairly modular, and you can take whichever you need.

### The Web Client

The Speeqe client is a JavaScript application that runs in standard Web browsers.  It is built on top of [Strophe](http://code.stanziq.com/strophe) and is almost entirely independent of the rest of the Speeqe project.  The one exception is that to prevent storing passwords in cookies, we store them in session variables on the server.  This means that these must be passed to and from Django, but it is pretty minor and easy to change.

This is the only piece you need if all you want is a Web based interface to already existing group chats.

### The Web Site And Web App

The Web site and application are written in Python and make use of the [Django](http://www.djangoproject.com) framework.  The Web portion essentially manages user creation, room creation, and authentication persistence for the Web client.

This piece is needed if you want to run a group chat creation and management service like [Speeqe.com](http://www.speeqe.com).

### The Multi-User Chat Server

Currently [Speeqe.com](http://www.speeqe.com) uses [ejabberd(http://www.ejabberd.im) and ejabberd's mod_muc to provide a local group chat service.  This is where new rooms are created by the Web application and where created user accounts are homed.  In addition to the stock ejabberd setup, we've also provided a mod_muc_logspeeqe module for logging the local group chat rooms to a [CouchDB](http://couchdb.org) database.  This is of course written in [Erlang](http://www.erlang.org).

You'll need this piece if you plan to host group chats and want them logged.

### Getting Started

Please see the [setup guide](http://code.stanziq.com/speeqe/wiki/SpeeqeSetup) to get started creating your own group chat service.  If you run into any trouble or need assistance, please ask on the [Speeqe mailing list](http://groups.google.com/group/speeqe).

## A Bit About The License

We've released Speeqe under the [Affero GPL license](http://www.fsf.org/licensing/licenses/agpl-3.0.html).   This is a [Free Software Foundation](http://www.fsf.org) endorsed license made for network accessed services like Speeqe.

The AGPL adds a clause to the standard GPL license that requires the source code to be made available to any network user of the software or its derivatives.  This means that if you start your own Speeqe-like group chat hosting service, your changes must also be available for everyone, even if you don't distribute the code.

This license has seen increased adoption by Web application developers and is used by projects like [Laconica](http://laconi.ca), the software behind [Identica](http://identi.ca).

## Start Speeqing

We hope that the community will find Speeqe useful as a basis for even better projects, and that it will help us fulfill our vision of simple, standards-based group chat for everyone.  We can't wait to see what happens!

Please let us know what you think in the comments or on the mailing list.
