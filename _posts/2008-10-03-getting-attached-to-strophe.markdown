---
layout: post
title: Getting Attached To Strophe
tags: [bosh, django, jabber, python, strophe, xmpp]
time: "14:28"
extended: ":EXTENDED:"
---

[Strophe](http://code.stanziq.com/strophe) continues to make progress thanks to the valuable feedback from its users.  One of the neat tricks that you can do with BOSH is session attachment.  A [BOSH](http://xmpp.org/extensions/xep-0124.html) session is established by some other piece of code, and Strophe attaches to the already existing stream.  This is used in features like passing a BOSH session from page to page or for auto-login on page load.  I've added an `attach()` method to `Strophe.Connection` to support session attachment and included an example Django project which shows how it is used.



:EXTENDED:

## When To Get Attached

Session attachment is very useful in a number of situations.  Here are two that I've discovered so far.

### Auto-Login And Hiding Credentials

If your Web application also includes an XMPP component, it might be the case that users have one set of credentials for both interfaces.  In this situation you can establish a BOSH session for the user without asking them to re-provide those credentials, making the user experience seamless.

One problem with this is that without session attachment you'd have to put the credentials into the rendered HTML page for Strophe to use.  This is not secure at all since that page may be cached and will probably traverse the Internet unencrypted.  However, the security problems can be avoided completely if your Web application establishes the BOSH session before rendering the page, and then passes only the session variables needed to continue the session into the resulting Web page.  Strophe then uses these session variables to attach to the session.

One thing to note is that even if the page is cached, an attacker can't easily use this data to hijack your session.  A successful attack would have to happen *during* your session, and it would have to occur before you used the session or quickly after you started using it.  The SID and RID variables that BOSH uses to identify sessions are useless unless you know the current RID or can guess it within a very small range (typical window sizes are around 5 to 7), and they become worthless as soon as that session is ended.

### Passing Sessions Around

If your Web application involves moving around over a variety of pages, you may want to pass a BOSH session around with the user so that they can continue to interact with the XMPP parts.  To make this as seamless as possible, it is necessary to keep a persistent session going in an iframe or via a popup or to pass the session state from page to page and let each page attach to it.

This can get complicated quickly, so session attachment may not be the best solution here.  For example, what happens when two pages are active at the same time?  Only one can attach to the session.  Perhaps someone clever will think of a great solution for this problem.

## An Example

I've written an [example Django application](https://github.com/metajack/strophejs/tree/master/examples/attach) which demonstrates how session attachment works.  It's pretty bare bones, but shows exactly how the feature works.

Django is used in the example, but any Web framework will probably have a very similar implementation.

For the example, the authentication information is stored in the Web application settings; in our case, this is `attach.settings`.  When a user requests the root URL the code establishes a BOSH session by making HTTP requests to the BOSH connection manager and passing along the credentials.  In the code, the `attach.boshclient.BOSHClient` class sets up the BOSH session and keeps track of its state.

Once the session is established, the HTML template is rendered which writes out the session state into global JavaScript variables:

    var BOSH_JID = "{{ jid }}";
    var BOSH_SID = "{{ sid }}";
    var BOSH_RID = "{{ rid }}";

Strophe is then passed this information, along with a callback for connection events, via the `attach()` method:

    connection.attach(BOSH_JID, BOSH_SID, BOSH_RID, onConnect);

From there on out it is business as usual for Strophe, and the session can be used exactly as if Strophe established the session itself.

## Strophe 1.0 Approaches

The release of Strophe 1.0 is imminent.  At this point it appears feature complete, and I am just waiting on some final feedback and testing before I wrap it up with a pretty bow.

Several people have asked about licensing, and the plan is currently to make StropheJs available under both the [GPLv3](http://www.fsf.org/licensing/licenses/gpl.html) and the [MIT license](http://www.opensource.org/licenses/mit-license.html).  This seems to work well for other JavaScript projects like [jQuery](http://www.jquery.com).  If you would prefer a different license, I'm happy to discuss it.

If you think it is still missing something or have any trouble at all, please file a bug at the [Strophe project page](http://code.stanziq.com/strophe) or leave a comment.
