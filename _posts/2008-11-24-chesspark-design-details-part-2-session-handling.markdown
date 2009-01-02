---
layout: post
title: "Chesspark Design Details Part 2: Session Handling"
tags: [chesspark, jabber, startups, xmpp]
time: "16:21"
extended: ":EXTENDED:"
---

In [part one](http://metajack.im/2008/11/21/chesspark-design-details-part-1-why-xmpp/) of this series I talked about why XMPP makes a good technology base for an online gaming platform like [Chesspark](http://www.chesspark.com).  Let's get a little more technical now, and look at specifically at how XMPP is used at Chesspark in the context of session handling.



:EXTENDED:

## Being A Good Citizen

One of the early design decisions we made at Chesspark was to embrace XMPP federation and the XMPP network.  We knew that a special gaming capable client would be needed, but we wanted any XMPP account on any federated server to be able to play.  We didn't want to force people to create accounts on our own XMPP server.

There were a few reasons for this.

For starters, we theorized that people with existing rosters would have an easier time promoting Chesspark to their friends if they didn't have to create them a second time or fiddle with importing them from another account.  We wanted to make it extremely easy for people to share their games and invite their friends.  

Another reason is that we felt that if Chesspark were open enough, and a good enough XMPP citizen, there might be some third party support for it in other clients or services.  We were thinking far into the future when more games than just chess might be available.

With this goal in mind, there are a number of immediate issues.

## The Price Of Federation

Participating on a federated network incurs some penalties and restrictions, but most of the them this price is well worth paying.  Here are a few pitfalls that affected us.

* **Feature deployments** -  Not every XMPP server supports the same features.  Specifically, [Google Talk](http://talk.google.com) doesn't support [private XML storage](http://www.xmpp.org/extensions/xep-0049.html) and few servers have [PEP](http://www.xmpp.org/extensions/xep-0163.html) deployed.  If you want to use such features, you must implement backup versions for servers which don't support them.
* **No local tricks** - Servers have complete control over local users.  We can forge packets to or from them, and we can access and manipulate their state directly.  In a federated network, such manipulations and forgeries aren't possible.  This means that if you need to access state, you need to do it in a way that works in the presence of remote users.

In Chesspark's case, the first thing that bit us was not being able to use local state access to detect presence of users.

## Managing Sessions

Many things inside Chesspark's game logic need to know the presence of users.  For example, if you invite a user to a game, the server needs to know whether that person is a member, whether or not they are currently online, and if they are already playing a game.  Since we can't just ask the database for the state of a remote user, we have to find another method.

One way to do this is to have presence subscriptions to each and every member.  This is cumbersome and overly verbose.  We don't need any of this information unless the user is using a Chesspark client, since otherwise their client can't participate anyway.  With over 400,000 members, managing such a roster would be a huge chore.

XMPP has a great solution for this - direct presence.  

## Direct Presence

If a presence stanza is sent directly to another user via the `to` attribute, the sender's server will make sure that the recipient is notified when they go offline.  It won't tell you about intermediate presence changes, but that person will know the online or offline state of the sender.  This is incredibly useful.

At Chesspark, the first thing any compatible client must do is send direct presence to a special component called `login.chesspark.com`.  This component's one and only job is to keep track of logged in Chesspark members and notify other parts of the system about this information.  Normal clients will not send this presence, and the Chesspark system will get no information about them - exactly what we want.

This is what it looks like:

<code>
<pre name='code' class='xml'>
    &lt;presence to='login.chesspark.com'/>
</pre>
</code>

It is simple, but quite effective.

## Session Info

It is often useful to have some information about each member's client or computer.  One could use [service discovery](http://www.xmpp.org/extensions/xep-0030.html) to query for such information, but it is more efficient just to have the Chesspark clients include this information directly in this initial direct presence.

Chesspark collects browser information and screen dimensions as well as the standard client version information.  Here is an example:

<code>
<pre name='code' class='xml'>
    &lt;presence to='login.chesspark.com' from='metajack@chesspark.com/cpc'>
        &lt;client-info xmlns='http://onlinegamegroup.com/xml/chesspark-01'>
            &lt;vender>Chesspark&lt;/vender>
            &lt;name>Chesspark Webclient&lt;/name>
            &lt;version>16194&lt;/version>
            &lt;os>Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.4) Gecko/2008102920 Firefox/3.0.4 (1101x656)&lt;/os>
            <ip>xxx.xxx.xxx.xxx</ip>
        &lt;/client-info>
    &lt;/presence>
</pre>
</code>

## Internal Notifications

Internally, the `login.chesspark.com` component publishes all presence changes to the other Chesspark components.  We currently do this just by sending special message stanzas to the other components, but it could also be done with [memcached](http://www.danga.com/memcached/) or some other way.  The way our code is designed, it was trivial to add this new message type and react to it, as opposed to worrying about how to get asynchronous notifications from some other system.

<code>
<pre name='code' class='xml'>
    &lt;message to='arbiter.chesspark.com' from='login.chesspark.com'>
        &lt;member-login xmlns='http://onlinegamegroup.com/xml/chesspark-01' 
                      jid='latency4@chesspark.com/watch_arbiter'/>
    &lt;/message>
</pre>
</code>

There is also a corresponding `member-logout` message.

## Final Thoughts

Using this method it is easy to track the presence of connection Chesspark clients, whether they are remote XMPP users or local ones.  Sure it is not quite as easy as a database query, but it allows any XMPP account in the federated network to participate as a first class citizen.

Next time I'll cover the game design, and we'll learn all about how Chesspark uses [multi-user chat](http://www.xmpp.org/extensions/xep-0045.html) to broadcast and share state with players and observers.
