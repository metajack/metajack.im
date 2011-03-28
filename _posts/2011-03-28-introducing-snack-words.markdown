---
layout: post
title: Introducing Snack Words
tags: [snackwords, ios, erlang]
time: "09:47"
extended: ":EXTENDED:"
---

The earliest things I remember about learning to write code are all
related to trying to create games. Whether it was learning basic
linear algebra to do 3D rotations or the basics of language parsing to
make text adventures, most of my early learning was a quest to
implement something silly. Over 20 years later, I've finally shipped
something silly.

[Snack Words](http://itunes.apple.com/us/app/snack-words/id425786167)
is a simple word game. You are given six tiles, and you must make as
many words from those letters as possible before time runs out. The
twist is that you aren't playing alone; you are playing head-to-head
against another person with the same tiles. Each game is short and
fun, like a snack.

<div style='width:480px;margin:10px;float:left'>
<iframe title="Snack Words video" width="480" height="390" src="http://www.youtube.com/embed/5zPQuqoUHqU" frameborder="0" allowfullscreen="yes"></iframe>
</div>

<a href='http://itunes.apple.com/us/app/snack-words/id425786167'>
<img src='/images/app_store_badge.png' width='200' height='100'>
</a>

I've been working on [Snack
Words](http://itunes.apple.com/us/app/snack-words/id425786167) in my
spare time over the last several months. I haven't yet written about
it here, but I left Collecta in early October and have been working on
a number of side projects since then. My wife and I did all the
game design in a few weeks of lunch conversations and then I wrote the
code between other projects. A small group of friends and family
helped beta test everything along the way. Now I'm playing a game I
created with people from all over the world.

The inspiration for the game came from a couple of places. My wife and
I spent some time addicted to similar games, although we always wished
for various features that were missing. When we decided to create
Snack Words, we already had a healthy list of ideas. Another source
came from my colleagues at Chesspark. We all wanted to make a
simplified version of the game that focused on fast games where you
didn't spend a lot of time matchmaking.

Please give it a try, and let me know what you think. I learned a lot
of great stuff along the way, which I'll be writing about here. For
example, I recently gave a [talk at Erlang Factory](http://erlang-factory.com/conference/SFBay2011/speakers/JackMoffit) where I showed how
Erlang made the game server a simple endeavor; in fact, it's just
slightly over 2,400 lines of code, including white space and
comments. You might also be surprised to learn that I did not use XMPP
for the protocol, and I have a post planned to explain that
decision as well.
