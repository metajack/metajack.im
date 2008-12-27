---
layout: post
title: "Echo Bot Part Two: Making A Component"
tags: [bot, code, component, jabber, python, twisted, wokkel, xmpp]
time: "17:34"
extended: ":EXTENDED:"
---

Many people write XMPP services as client bots, but the problem with this is that this doesn't scale well.  The first step to [improving the scalability of an XMPP service](http://metajack.im/2008/08/04/thoughts-on-scalable-xmpp-bots/) is to implement the service as a server component.  To demonstrate this, I will revisit the [echo bot tutorial](http://metajack.im/2008/09/25/an-xmpp-echo-bot-with-twisted-and-wokkel/) and turn it into an XMPP server component.  This turns out to be remarkably easy with [Twisted](http://www.twistedmatrix.com) and [Wokkel](http://wokkel.ik.nu).



:EXTENDED:

## Sub-Protocols To the Rescue

We created an echo bot protocol in the [previous example](http://metajack.im/2008/09/25/an-xmpp-echo-bot-with-twisted-and-wokkel/) which listened for incoming messages and replied to those messages.  For our component, we want to do the same thing.

Wokkel is designed so that sub-protocols are mostly agnostic to the type of underlying connection.  This means that we can re-use the *exact same code* for our componentized echo bot.  Actually, we'll make one tiny change to the `EchoBotProtocol` class since the original version sends initial presence to the server, which is only required for client connections.

Below is the new `echobot.py`.  Note that we've added a very simple constructor, and we check `self.client`  in `connectionMade()` to determine if initial presence should be sent.

    from twisted.words.xish import domish
    from wokkel.xmppim import MessageProtocol, AvailablePresence
    
    class EchoBotProtocol(MessageProtocol):
        def __init__(self, component=False):
            MessageProtocol.__init__(self)
            self.component = component

        def connectionMade(self):
            print "Connected!"
    
            # send initial presence we're a client
            if not self.component:
                self.send(AvailablePresence())
    
        def connectionLost(self, reason):
            print "Disconnected!"
    
        def onMessage(self, msg):
            print str(msg)
    
            if msg["type"] == 'chat' and hasattr(msg, "body"):
                reply = domish.Element((None, "message"))
                reply["to"] = msg["from"]
                reply["from"] = msg["to"]
                reply["type"] = 'chat'
                reply.addElement("body", content="echo: " + str(msg.body))
    
                self.send(reply)

We've made no substantial changes to the code, and if we hadn't made these changes, the code would still work.  If you send `<presence/>` as a component, the server will just reply with an error, and the connection will not otherwise be affected.

## Application Changes

The main change that we must make is to `echobot.tac`, the Twisted application file.  The change is fairly trivial; we need to replace the use of `XMPPClient` with `Component`.  The `Component` class takes two extra parameters since a component must know what server to connect to and what domain it will appear as.  The rest of the changes to the file consist of changing the import statement and renaming the `xmppclient` variable.

    from twisted.application import service
    from twisted.words.protocols.jabber import jid
    from wokkel.component import Component
    
    from echobot import EchoBotProtocol
    
    application = service.Application("echobot")
    
    xmppcomponent = Component("example.com", 5347, "echo.example.com", "pass")
    xmppcomponent.logTraffic = False
    echobot = EchoBotProtocol()
    echobot.setHandlerParent(xmppcomponent)
    xmppcomponent.setServiceParent(application)

The first and second arguments to the `Component` constructor are the domain of the server and the port at which the XMPP server listens for component connections.  The third argument is the JID that the component will become.  The last argument is the component password.

Just as with the original echo bot, we can run the component version with `twistd -ny echobot.tac`.

## Server Configuration

An XMPP service built as a client needs to have an account to use; an component service needs some configuration as well.  Generally the server must to configured to listen for component connections and the password must be set.  

The configuration section below is for [ejabberd](http://www.ejabberd.im), but other servers will probably have something very similar.  The following lines go into the `ejabberd.cfg` listen section.  Similar lines should already be there but commented in the default configuration file.

    {8888, ejabberd_service, [
                              {access, all},
                              {hosts, ["echo.example.com"],
                               [{password, "pass"}]
                              }
                             ]},

This will set ejabberd to listen on port 8888 for component connections and will allow the component to assume the JID of echo.example.com.

## Components Are Easy

Writing components is not hard.  In Wokkel and Twisted Words, it is exactly as much work as a client, except that you use a different connector.  At the protocol level, the [Jabber Component Protocol](http://xmpp.org/extensions/xep-0114.html) is quite a bit simpler than making normal client connections.  The XMPP server does no extra work such as maintaining a roster or routing stanzas in a fancy manner, and this is why a component service scales better than a client service.

I knew that components were easy since we had already implemented many different ones with Twisted for [Chesspark](http://www.chesspark.com).  It was a nice surprise to find out that the only change needed to turn my echo bot example in Wokkel into a component echo bot was to alter the application file.

The next time you're building an XMPP service, I highly recommend starting with a component and giving Twisted and Wokkel a try.
