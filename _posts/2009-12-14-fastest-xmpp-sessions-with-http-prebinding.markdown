---
layout: post
title: Fastest XMPP Sessions with HTTP Pre-Binding
tags: [xmpp, jabber, bosh, prebind, strophe]
time: "15:38"
extended: ":EXTENDED:"
---

XMPP session establishment is normally quite fast over native sockets,
but over BOSH, the round-trip latency of several request and response
pairs can be quite high. Among its other benefits, [session
attachment](http://metajack.im/2008/10/03/getting-attached-to-strophe/)
provides a great solution to this problem.

I first heard of this technique for rapid session bootstrapping, called *pre-binding*, bootstrapping from [Andy Skelton](http://andyskelton.com/). Andy had
written a module for [im.wordpress.com](http://im.wordpress.com) that
in a single HTTP request created and provided the credentials Strophe needs to
attach to an existing session.  This session was already
authenticated, meaning that the first request Strophe sends can be a
real, application-level request.

:EXTENDED:

For example, a normal BOSH session must connect and authenticate to an
XMPP server.  This typically takes about 4 to 5 stanzas, each of which
must wait for a response before proceeding. Assuming a 100 millisecond
round-trip time, this is about half a second of latency.  While not
much, this is directly perceptible to users.  A pre-bound requests
however, involves only one round-trip, turning half a second into a
small 100 milliseconds.

Andy has kindly made his
[http\_prebind](http://github.com/skeltoac/http_prebind) module
available on [his GitHub account](http://github.com/skeltoac), if
you'd like to try it out.

[Collecta](http://www.collecta.com) uses this same technique, however
we use it with anonymous sessions.  Any BOSH client can connect to
[http://collecta.com/http-pre-bind](http://collecta.com/http-pre-bind)
and instantly receive credentials for an anonymous session to
guest.collecta.com. This makes our own client's start-up time near
instantaneous.  In fact, we've gone even further by having the web
application server make this request before the HTML is returned and
embed the credentials into the page; an anonymous session is ready and
waiting as soon as the JavaScript code starts executing.

Today, we've made our own
[Mod-Http-Pre-Bind](http://github.com/thepug/Mod-Http-Pre-Bind) code
available, and I've written a [small example](http://github.com/metajack/strophejs/raw/master/examples/prebind.js) for using this with
[Strophe.js](http://code.stanziq.com/strophe).  I'll go over the
salient parts of this example in the rest of this post.

Instead of connecting normally, an AJAX request is made to the
pre-bind service. I've used [jQuery](http://jquery.com) for the code
below, but any AJAX library will work just as well:

<code>
<pre name='code' class='javascript'>
// attempt prebind
$.ajax({
    type: 'POST',
    url: PREBIND_SERVICE,
    contentType: 'text/xml',
    processData: false,
    data: $build('body', {
        to: Strophe.getDomainFromJid($('#jid').val()),
        rid: '' + Math.floor(Math.random() * 4294967295),
        wait: '60',
        hold: '1'}).toString(),
    dataType: 'xml',
    error: normal_connect,
    success: attach});
</pre>
</code>

The code sends an HTTP POST request containing a BOSH-like &lt;body/>
element with the initial RID, the domain to connect to, and the hold
and wait values.

The pre-bind service will return a &lt;body/> tag in its response like
the one shown here:

<code>
<pre name='code' class='xml'>
&lt;body xmlns='http://jabber.org/protocol/httpbind' 
      sid='892efca20cea238958f0603f89a6f8472ef790fe' 
      rid='2219367495'>
  &lt;iq xmlns='jabber:client'
      id='_bind_auth_2'
      type='result'>
    &lt;bind xmlns='urn:ietf:params:xml:ns:xmpp-bind'>
      &lt;jid>22720631691260831658412599@guest.collecta.com/37436661951260831658614586&lt;/jid>
    &lt;/bind>
  &lt;/iq>
&lt;/body>
</pre>
</code>

You can simply extract the JID, SID, and RID values straight out of
this response, and use them to call <code>attach()</code>:

<code>
<pre name='code' class='javascript'>
function attach(data) {
    log('Prebind succeeded. Attaching...');

    connection = new Strophe.Connection(BOSH_SERVICE);
    connection.rawInput = rawInput;
    connection.rawOutput = rawOutput;
    
    var $body = $(data.documentElement);
    connection.attach($body.find('jid').text(), 
                      $body.attr('sid'), 
                      parseInt($body.attr('rid'), 10) + 1, 
                      onConnect);
}
</pre>
</code>

Now you have an established, anonymous session to the server, ready
for immediate use.

It just doesn't get much easier or faster than that!

There's a whole chapter of [my book](http://professionalxmpp.com) on
the topic of session attachment and its various uses. It's starting to
become an important technique for XMPP web applications.

