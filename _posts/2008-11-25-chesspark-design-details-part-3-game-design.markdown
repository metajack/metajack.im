---
layout: post
title: "Chesspark Design Details Part 3: Game Design"
tags: [chess, chesspark, jabber, startups, xmpp]
time: "16:40"
extended: ":EXTENDED:"
---

In [part one](http://metajack.im/2008/11/21/chesspark-design-details-part-1-why-xmpp/) we discussed the merits of [XMPP](http://www.xmpp.org) as a basis for [Chesspark](http://www.chesspark.com), and in [part two](http://metajack.im/2008/11/24/chesspark-design-details-part-2-session-handling/) we explored session handling.  Now we'll jump into the heart of Chesspark, which is the game design.  



:EXTENDED:

## A Little About Chess Games

Chess is a game with no secrets, only strategy.  In game theory, this is called [perfect information](http://en.wikipedia.org/wiki/Perfect_information).  Each player, and everyone watching, has all of the game state at all times.  One of our tasks is to ensure that everyone has access to the game state and is notified of any state changes as they happen.

Chess is also a game with rules, and these rules must be enforced.  In casual games this is enforced by social contract; if you violate the rules no one will play with you.  Since social contracts are practically useless on the Internet, another task for us is enforcing the game rules.

Chess is a timed game.  Many people who have played only casually will have never played chess with a clock, but this is how serious chess is played.  There are several timing systems.  The most basic one gives each player a fixed amount of time to make all moves.  We'll need to keep everyone's game clocks synchronized.

Chess is also full of meta-rules that govern tournaments and club play as well as ranking systems for competition.  Where appropriate, we'll need to implement these.  For example, people expect to have a chess rating, and they expect that bad behavior will be discouraged.

## Chesspark Design Principles

There are several principles that we adopted very early.

* **The arbiter** - Since peer to peer rule enforcement leads to unhappy players when one person cheats, we wanted to enforce game logic as a third party.  This means that each player trusts this enforcer, call the arbiter, which manages game state changes.
* **Watching games** - Watching other people play is fun, especially when the game is close, the players are friends, or the action is fast.  We wanted to support watching games as well as playing them.
* **True to life** - Chess is played in person often, and this is how most people are familiar with the game.  We wanted to make sure that playing chess at Chesspark stayed as close to real life chess as possible.

These decisions help shape much of our technology at Chesspark, and except for staying true to life, are applicable to most any game.

## Broadcasting State

There are two big tools for broadcasting information in XMPP - [pubsub](http://www.xmpp.org/extensions/xep-0060.html) and [multi-user chat](http://www.xmpp.org/extensions/xep-0045.html).  Chesspark uses both tools for different purposes.  For broadcasting game state, we chose multi-user chat.

Multi-user chat (MUC) already has many of the important pieces we needed for a game.  Each game is represented by a room.  All the participants in a game can talk and interact with each other.  Game state is just another message to the room.  MUC participants have roles which tell everyone how they are related to the room, and each participant has presence information on the others.

Pubsub, in contrast, does not have a good way for subscribers to know about or interact with one another.  If there was a pubsub node representing a game, each participant would have to be a publisher in order to broadcast presence and chat messages.  It can be done, but MUC seemed the more natural fit.

## Extending MUC

We extended normal MUC in a few different ways to support some of the Chesspark features.  

First, we added a new player role.  Having a player role allows occupants to see who the two players are easily.  Without the role, each occupant would have to ask the arbiter who the players were.  Having a new role also let's us change the communication rules.

### Special Delivery

Normally in a MUC people talk and everyone can see it.  There are also moderated rooms where only people with permission to talk can do so, but even in this case, all occupants can see what is said.  This isn't so great for chess games.

Chess takes a lot of concentration, and we didn't want idle conversation among game watchers to interrupt the players.  This follows from our principle of staying true to life.  In a real life tournament, it is considered quite rude to stand next to players and start talking.  The area surrounding players is kept quiet.

Another issue is that people watching chess games want to discuss the moves, potential tactics, and future plans.  Players, however, are not allowed to receive advice or help from anyone, so if they can see the chat of watchers, then there is a real problem.

We solved this by making roles affect who sees chat messages.  In a chess game room, players can send messages and these messages are seen by everyone in the room.  Regular participants can also talk, but only other regular participants can see their messages.  A player never sees any chat from an observer during a game.  Once a game is over, the players can see the observers' chat messages.

Another feature related to this is to have a special chat mode where a player can send a message *only* to observers.  The other player will never see it.  This allows banter matches, where players share their strategy with the participants without revealing their plans to the opponent.

### The Need For Palaver

No existing MUC implementation was extensible in the way we needed it, so we were forced to write our own.  The result is a pluggable MUC implementation called [Palaver](http://code.stanziq.com/palaver).   Palaver can be extended via plugins to support the features Chesspark required and many other types of new behavior.

There are three types of plugins for Palaver, join, presence, and message.  Join plugins control access to the room. A presence plugin can inject extended stanzas into room presence.  Message plugins affect message delivery and acceptance.

Chesspark uses all three types.  We use a join plugin to keep out non-members from the game rooms.  We use a presence plugin to include extra information like professional chess titles or Chesspark specific member roles.  Finally, the message plugin uses the occupant's role to affect message delivery.

## Initial State And Clocks

When players first join a game room, they need to know the current state.  Sending them state updates will not be helpful unless they have the current state as context.  Arbiter handles this by watching for room joins and then sending out the current copy of the state privately to the person who joined.  Move numbers are communicated in the initial state and in the state changes, so the new participant will always know which information is new.

Clocks updates are sent periodically by the arbiter to all players, and the current time is also sent with any board state changes.  This allows everyone to keep in sync.

## Game State Changes

Any time a player manipulates game state, the request is sent directly to the arbiter via an `<iq/>` stanza.  The arbiter can accept the action or reject it as illegal or malformed.   If the action is legal, the arbiter will broadcast it via a `<message/>` to the game room.

For example, a player sends arbiter a move request:

<code>
<pre name='code' class='xml'>
    &lt;iq to='arbiter.chesspark.com' from='metajack@chesspark.com/cpc' 
        type='set' id='move1'>
        &lt;game xmlns='http://onlinegamegroup.com/xml/chesspark-01'>
            &lt;move>e2e4&lt;/move>
        &lt;/game>
    &lt;/iq>
</pre>
</code>

Instead of a `<move/>` element, we might also have `<resign/>`, `<addtime/>`, `<draw/>`, etc.

Arbiter determines whether this move is legal.  Is it our turn?  Is there a piece in this location?  Can that piece be moved to the destination?  If it's legal, arbiter will return an empty result to us, and broadcast the message to the room:

<code>
<pre name='code' class='xml'>
    &lt;iq from='arbiter.chesspark.com' to='metajack@chesspark.com/cpc' 
        type='result' id='move1'/>
    &lt;message from='1234@games.chesspark.com/Arbiter' 
             to='1234@games.chesspark.com' type='groupchat'>
        &lt;game xmlns='http://onlinegamegroup.com/xml/chesspark-01' 
              white='metajack@chesspark.com' black='trainer@chesspark.com' 
              id='1234'>
            &lt;move player='metajack@chesspark.com' side='white' ply='1' number='1'>
                e2e4
            &lt;/move>
            &lt;time control='0' side='black'>1800.0&lt;/time>
            &lt;time control='0' side='white'>1800.0&lt;/time>
        &lt;/game>
    &lt;/message>
</pre>
</code>

Note that arbiter includes the move number, the ply (or half-move) number, the side, the player name, the move, and the current clock states.  A client can easily detect if this state change is already included in their known state by checking the ply number, and it has all the information it needs to update to the new state and synchronize the clocks.

## Stay Tuned

There are still a few more things to cover regarding game design.  Specifically, how are games negotiated and created?  How are ratings handled?  What about cheating, abuse, and all the edge cases?

We'll cover those in the next installment.
