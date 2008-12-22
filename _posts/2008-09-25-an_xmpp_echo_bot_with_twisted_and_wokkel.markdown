---
layout: post
title: An XMPP Echo Bot With Twisted And Wokkel
tags: [bot, code, jabber, python, twisted, wokkel, xmpp]
time: "15:53"
extended: ":EXTENDED:"
---

[Twisted](http://twistedmatrix.com) is one of the best ways to write XMPP software, but it is pretty poorly documented.  It's gotten even better with [Ralph Meijer's](http://ralphm.net/) work on [Wokkel](http://wokkel.ik.nu), which extends Twisted's XMPP support with subprotocols and other goodies.  To show you just how easy Twisted and Wokkel make things, here is a simple echo bot.


:EXTENDED:

## Prerequisites

Getting the things you need will probably take longer than writing the code.  Luckily, your second project with Wokkel will materialize much faster.

You'll need:

* Python
* Twisted 8.x.  This is included in most Linux distributions our you can get it from [Twisted Python's Web site](http://twistedmatrix.com).
* Wokkel.  Grab the latest from the [repository](https://svn.ik.nu/wokkel/trunk).

Once these are installed or in your Python path, you can proceed to the actual code.

## An Echo Bot Sub-protocol

Our echo bot will speak a custom sub-protocol of XMPP.  It will listen for any message stanzas and then reply to some of them.  We'll put this code in `echobot.py`.

    from twisted.words.xish import domish
    from wokkel.xmppim import MessageProtocol, AvailablePresence
    
    class EchoBotProtocol(MessageProtocol):
        def connectionMade(self):
            print "Connected!"
    
            # send initial presence
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

Some things to note about this code.  A `MessageProtocol` simply looks for messages and calls `onMessage` when one is received.   `MessageProtocol` inherits from `XMPPHandler` which is the base class for all sub-protocols.  `XMPPHandler` will call `connectionMade` and `connectionLost` on connect and disconnect, just like other Twisted protocol classes.

All the connection details and authentication are handled by the `XMPPClient` service, which we will see next.

## The Application

Twisted includes an application runner called `twistd` which takes a `.tac` file as input.  The tac file sets up the various services that compose the application and manages their life cycle.  It takes care of making things a daemon, handling PID files, and many other tasks common to applications.

Here's the `echobot.tac` file:

    from twisted.application import service
    from twisted.words.protocols.jabber import jid
    from wokkel.client import XMPPClient
    
    from echobot import EchoBotProtocol
    
    application = service.Application("echobot")
    
    xmppclient = XMPPClient(jid.internJID("someuser@example.com/echobot"), "pass")
    xmppclient.logTraffic = False
    echobot = EchoBotProtocol()
    echobot.setHandlerParent(xmppclient)
    xmppclient.setServiceParent(application)

Be sure to replace 'someuser@example.com' and 'pass' with a real JID and its password. The echo bot application can now be started with `twistd -ny echobot.tac` or `twistd -y echobot.tac` if you want to daemonize it.  Once it is running, go ahead and send it a message!

Every tac file must defines the application variable.  Usually you'll create some services for the application and then use `setServiceParent` to make them part of the application.  For `XMPPClient` services, we have to use a similar method to activate our sub-protocol handler; we call `setHandlerParent` to make our sub-protocol part of the `xmppclient` service.

##  What Next?

Building sub-protocols is pretty straight forward.  You can look at the MessageProtocol code for an example; it is less than 30 lines including blank lines and comments.   Generally XPath expressions are set up to listen for particular stanzas, and these call specific handlers when the stanzas are received.

Wokkel also contains a pubsub client protocol and a pubsub service protocol implementation.  Making little pubsub daemons should be quite easy with these.

I'm really excited about Wokkel, and hopefully I can write up some more complex tutorials soon.
