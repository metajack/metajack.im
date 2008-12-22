---
layout: post
title: "Chesspark Design Details Part 1: Why XMPP?"
tags: [chess, chesspark, code, jabber, startups, xmpp]
time: "15:12"
extended: ":EXTENDED:"
---

I've been asked several times to talk a bit about how we built [Chesspark](http://www.chesspark.com), how it uses XMPP, and what various lessons we learned along the way.  This is way too much for a single blog post, so I'll be doing a small series of them on Chesspark's design.  To kick things off, let's discuss why someone would want to build a game system on top of XMPP in the first place.



:EXTENDED:

## Why XMPP?

It is certainly possible to build something like Chesspark without XMPP, and [others](http://www.chessclub.com) have done so.  XMPP does offer many advantages of interest for games.

### People Are Social

Humans are social creatures, and they like to communicate with one another.  Any multiplayer game involves some social interaction, and this interaction soon becomes of primary importance.  You have only to look at the enormous amount of [World of Warcraft](http://www.worldofwarcraft.com) guilds to see this.  

At first, everyone is interested primarily in the game.  They solve puzzles, perform quests, kill monsters, or just interact with the game world.   As they play, they meet people and form relationships.  Pretty soon they are using the game as a shared activity for socializing with friends.  Take their friends away, and the game isn't nearly as interesting.

### IM Is Already A Social Network

Instant messaging is one of the oldest computer social networks.  It has all the things that you need: friends lists, presence, avatars, private chats, and group chats.  Choosing XMPP as a basis for a game means that it starts off as a first class social network; there is no need to bolt on these features later.

Starting with the social aspects first means that the most important piece will be integrated at a deep level in the design.   Those that start with game rules often end up wedging social features in afterwards, and this can make for a poor experience.

To give an example, our competitor the [Internet Chess Club](http://www.chessclub.com) also has a friends list and group chat, but these features are tacked on.  There are a fixed number of numbered (not named) group chat rooms, and none of the client UI makes the friends list front and center like people expect from IM clients.  Chesspark operates like an IM client, a user interface that many people understand and are familiar with.  Group chat rooms can be private or public, have descriptive names, and their own participants lists that users can interact with.

### Real Time Is Important

Another reason for XMPP is that it is built for real time communication, and this is a pretty necessary ingredient to an often fast paced game like chess.  Most other Web sites for chess have turn based or play by e-mail systems, but we wanted Chesspark to support the super fast bullet and blitz chess games.  In bullet and blitz players have one minute or five minutes to make all of their moves.  This means that latencies must be minimized.

XMPP has all the tools already available for dealing with this situation.  It has [pubsub](http://www.xmpp.org/extensions/xep-0060.html) for subscribing to asynchronous notifications, [BOSH](http://www.xmpp.org/extensions/xep-0124.html) for bridging to the Web, and [Multi-user chat](http://www.xmpp.org/extensions/xep-0045.html) for creating shared real time interaction spaces.

### Work On Implementation Instead Of Design

Using XMPP allowed us to save countless hours, by letting us focus our efforts on great implementation instead of re-designing another protocol and associated tools.  We found that many things that we needed had already been created, and this let us get to market faster and resulted in more reliable software.

In some cases we had to design our own implementations of XMPP services, like the [Palaver](http://code.stanziq.com/palaver) group chat server.  Even with these cases, we were able to implement a protocol that was already well designed instead of designing and implementing some protocol.

Protocol design is not trivial, and starting from such a robust base of protocols and tools is reason enough to choose XMPP.

## For Next Time

Here are some of the topics I plan to cover:

* Session handling - Games have state that must be tracked, and part of this state is the presence of players.  We faced additional challenges by choosing to make Chesspark a good citizen of the federated XMPP network, but it turns out they were easily solved.
* Game design - Why did we choose to use multi-user chat as the primitive for games?  How and where are game rules checked?  
* Cheating and edge cases - What happens when a player disconnects during a game?  How do we detect and prevent various abuses?
* Tool choices - There are a lot of great XMPP tools, and I'll give some rationale about the choices we made.
* Infrastructure and optimization - We went through several iterations of infrastructure and have spent many hours fine tuning latency, query times, and user experience.

If you have any questions or topics that I didn't mention, feel free to chime in.  I'll try to cover everything I can.
