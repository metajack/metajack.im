---
layout: post
title: What You Can Learn From Emacs
tags: [chesspark, code, editor, emacs, startups]
time: "08:40"
extended: ":EXTENDED:"
---

I almost cried last week.  For the first time since high school, I lost hours of writing work in an instantaneous failure of software.  Later in the week, I found myself looking for some unrelated Emacs information and ran across a description of a feature that would have prevented my ordeal.  New and experienced programmers alike could many things from Emacs; there is a treasure trove of stored wisdom lurking inside.

:EXTENDED:

## Die, Auto-save, Die!

I didn't lose my data because I forgot to save; that habit is ingrained from years of previous experience with buggy software.  I lost the data because auto-save is not your friend.  Auto-save is evil.

It happened too fast.

My first mistake was that I was writing in the browser, and it is a mistake I will not repeat again soon.  The browsers and JavaScript programmers have responded to other users with similar frustrations by implementing form field persistence across crashes and "helpful" features like auto-save.

I was in the grove, writing at a good clip.  My hands managed to find the undocumented key binding for *delete the entire text box*, and I was left staring at an empty screen.  My reflexes kicked in with **"Undo, undo, undo!"**, but whatever mysterious function I had invoked apparently also wiped out the undo history.

I quickly realized that the page was a ticking time bomb.  At any moment, auto-save was going to make my blank screen permanent.  I quickly closed the browser tab, only to be stopped by another "helpful" feature.  *"Do you really want to close this tab?  You have unsaved changes."*  Yes! Finally, the application was gone.  

My plan was to go back and resume work at the last auto-save point, or barring that from the last time I had obsessively hit save manually. Mere seconds later, my hopes were destroyed as the empty box filled the screen once again.  Auto-save, the evil bastard, had managed to fire off a parting shot.

## Emacs Auto-save Is Considerate

Days later, I ran across this [page](http://www.surfaceeffect.com/thoughts/emacs) describing some pros and cons of Emacs.

> Another nice feature is auto-saving. This might seem a pretty run of the mill feature, but, as is typical of emacs there are understated subtleties waiting to be discovered. Recently I was editing a web page and I killed (roughly speaking, emacs’ equivalent of cut) a large fraction of the document. Emacs displayed a brief message saying something to the effect that I’d just deleted a large piece of text and because of that it had disabled auto-save. It did this to make sure that should I want that piece of text back I had the option. This was in addition to the standard undo facility. The reasoning being that should emacs or the operating system crash, it would do least harm that way. Now that is considerate software! 

It makes a lot of sense.  If you delete a substantial portion of the text, auto-save immediately stops.  It can resume once you've explicitly saved again.

It is exactly features like these that make Emacs indispensable for many.

## Learn This And More

If you want to be a great programmer, you must learn from other great programmers and other great programs.

When people request a feature like auto-save, instead of implementing a naive and evil auto-save that runs only on a timer, research a little bit to find out what the well respected implementations do.  After reading a few pages of Google results for auto-save issues, I can see that few do this.

Almost every problem has been encountered before.  For most problems you will find a range of solutions that have different tradeoffs.  Do your users a favor and investigate the solutions of others instead of re-inventing the same mistakes that led to those solutions.

## An Example

Previous incarnations of the [Chesspark](http://www.chesspark.com/) software generated complaints about users ducking out of lost games by disconnecting.  How to solve this?

One solution is to forfeit the disconnecting player.  Another is to adjourn the game to be resumed at a later time.  These are the solutions generally familiar to our users from other sites, but they did not satisfy us.

After some research, we found the solution with the best tradeoffs.  It did not come from Emacs or even from any other computer program.  It came from real life.

In a real life tournament, players get up and walk away and never come back.  How do tournament directors handle this situation?  They set some reasonable time period for the opponent to return, and if she doesn't, they forfeit the player.  This has the property that if the player needed to use the bathroom or go make an emergency phone call, they haven't lost the game. If they leave longer than the tournament directory deems reasonable, they forfeit.

We use this solution at Chesspark as well.  If you are disconnected, you have a certain amount of time to reconnect without losing the game, although you will be penalized by losing time if it is your turn, exactly like real life.  With this solution, you only lose the game in an exceptional circumstance such as your Internet access going down for a while or some emergency which demands your prolonged attention.  Users understand and are accepting of the loss in these situations, and their opponents are happy for the swift resolution as well.

Had we just gone with our first naive ideas, some users would be pretty unhappy, but by thinking about how others solved the problem, we were able to satisfy almost all of them.

Whether it be from Emacs, some other program, or real life, take the work of others and use it to make your work better.  Your users will appreciate it.
