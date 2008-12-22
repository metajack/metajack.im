---
layout: post
title: Faster QA with Screenshots
tags: [chesspark, code, osx, qa, quicksilver, screenshots]
time: "15:40"
extended: ":EXTENDED:"
---

In any given day, I find a lot of bugs.  This is inevitable with software, especially software you are developing.  I seem to have a knack for finding new bugs exactly when I'm in the middle of doing something else that is more important or requires concentration.  The trick to capturing this information without getting side tracked is screenshots.

For web apps or desktop applications, even if a bug is not rendering related, a selective screenshot often has all the information you need to file a report at some later time.  On most platforms you can find a way to take these screenshots with a minimal set of keystrokes.  This has many benefits:
<ul>
	<li>screenshots are often the most efficient way to communicate the bug and you should probably have them anyway</li>
	<li>screenshots are easy to compare making bug fix verification especially easy in many cases</li>
	<li>you'll be more likely to report bugs since capturing bug information is not interruptive</li>
</ul>
Read on for how I use OS X and Quicksilver to make this method especially painless.


:EXTENDED:



Although you can use this trick on pretty much any platform, Mac OS X and Quicksilver can make this process almost invisible.

OS X includes a handy key combo for taking quick screenshots: Command+Shift+4.  This immediately changes the cursor to allow you to select an arbitrary region of the screen.  When you release the button after completing the selection, whatever was on screen inside your selection is saved on your desktop as "Picture N.png" where N is 1 or 23, etc.  Here is an example taken from the <a href="http://www.chesspark.com/">Chesspark</a> windows client (running in Parallels).

<img src="http://metajack.files.wordpress.com/2007/03/screenshot-example.png" alt="screenshot-example.png" />

You can also take a screenshot of the entire window by hitting Command+Shift+4 and then hitting the spacebar.  The cursor will change to a camera and whatever window you click on will be captured just as if you had selected it manually.

Unfortunately, once you start doing this a lot, your desktop will be filled with files called Picture N.  If a bug is non-obvious you may forget why you took the picture.  Finding the picture and renaming it manually takes too much effort.  To avoid getting distracted the process needs to be streamlined. Thankfully, <a href="http://quicksilver.blacktree.com/">Quicksilver</a> with a  little Applescript can get you fast screenshots and name them so you know what they are.

The script below should be copy and pasted into Script Editor, saved as Screenshot.scpt, and placed in ~/Library/Application Support/Quicksilver/Actions (if this directory doesn't exist, just create it).  You may have to restart Quicksilver in order for it to see this new action.

Now to take a screenshot invoke Quicksilver (Command+Space or Control+Space depending on how you have it set up usually), and hit '.' to enter text mode.  Then, type a short description of the shot such as "bad alignment on login dialog" and hit Tab and start typing "screenshot".  For me as soon as I hit the "s", Quicksilver figures out I want a screenshot and completes it thanks to its learning algorithm.  I finish by hitting enter which changes the cursor to select the region.  Once selection is done, Quicksilver is back out of my way and I'm right where I left off.  After doing this a few times it becomes very natural and takes pretty much no brainpower.

Invoking Quicksilver:

<img src="http://metajack.files.wordpress.com/2007/03/quicksilver-qa.png" alt="quicksilver-qa.png" />

Resulting "bad alignment in login dialog" screenshot:

<img src="http://metajack.files.wordpress.com/2007/03/bad-alignment-on-login-dialog.png" alt="bad-alignment-on-login-dialog.png" />

When I'm finish with whatever I'm doing or at the end of the day, I can go through all the shots I took and enter them into our bug tracking system.  Having the screenshot also makes communicating the bug a lot easier.

Screenshot.scpt below:
<pre style="overflow:auto;background-color:#eeeeee;">
using terms from application "Quicksilver"
	on process text theString
		-- Change save_location to the directory you want to store screenshots in. Make sure it ends with a '/' as below.
		set save_location to "/Users/jack/Desktop/"
		set theFilename to quoted form of (save_location &amp; theString &amp; ".png")
		set theCommand to "screencapture -i " &amp; theFilename
		do shell script theCommand
		return
	end process text
end using terms from</pre>
