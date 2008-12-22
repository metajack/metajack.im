---
layout: post
title: On Moderation Of Chats
tags: [chat, chesspark, community, jabber, moderation, startups, xmpp]
time: "08:20"
extended: ":EXTENDED:"
---

If you give some normal people anonymity and an internet connection their behavior becomes atrocious.  This is unfortunately very obvious when anyone joins any public discussion on the Internet.  The public jabber conference rooms have <a href="http://matthewstechnologyblog.blogspot.com/2007/07/sign-of-jabbers-increasing-popularity.html">been dealing with this problem</a> as the popularity of XMPP increases.  At Chesspark we run into this problem a lot, and we've tried a lot of different things to improve the situation.  Here are some of the things other communities do, and some which have worked for us.

<strong>A Blunt, But Ineffective Solution</strong>

Some services attempt to curb swearing and abusive language by reverse censorship.  Instead of filtering out bad words, they whitelist words that can be used.  This is the tactic employed by Disney's Virtual Magic Kingdom community (and probably other child focused sites).  I think this is an ineffective solution.

For starters, language is a wonderfully fluid thing.  It is common and natural for the meanings of words to change or be co-opted for various purposes.  Limiting people to a small subset of language does not necessarily place much limit on their ability to express themselves.  People will just adopt new meanings for common words in order to communicate their throughts. This creates an environment where new members of the community will become frustrated as they try and come to terms with why seemingly normal speech is not allowed.  They will have to learn the social norms of this reduced langauge set.  Once learned, it is a short path to being abusive if they choose to do so.

The whole point of this wonderful Internet is to allow humans to communicate faster, better, cheaper, and with a much wider audience.  It seems downright stupid to me to try and hinder this by using some kind of reduced language whitelist.

<strong>Blacklisting</strong>

The opposite stance is to blacklist certain words that are considered offensive or abusive.  The problem with with blacklisting is that the number of potentially offensive words is staggering.  Club Penguin claims to be <a href="http://www.gamesindustry.biz/articles/mmo-week-industry-has-been-irresponsible-with-kids">adding 500 to 1,000 words to their filter</a> every day.  The problem with this method is similar to the above.  Blacklisting treats the langauge as a static item.  Every time you add 1,000 words to the list, users will discover ways to corrupt the meanings of new words.  Pretty soon you are putting some pretty ridiculous limitations on people's normal speech.

A small blacklist of basic, common swear words is pretty much the limit of this technique.  At Chesspark, we have implemented an optional blacklist of this type in the style of World of Warcraft.  By default, these blacklisted words are replaced by comic book swears (#@#$), but at any time the user may visit the preference settings and opt to see the original language.  This doesn't stop the speech, but it does seem to deter it a bit.  Also, the first time experience for people is improved greatly if they are sensitive to this kind of language.

<strong>Manual Moderation</strong>

Manual moderation is employed nearly everywhere, but it takes a lot of time to manually police a website.  While this kind of moderation can distinguish common abusive speech from normal speech using the same vocabulary, it is certainly not perfect.  Offensive language is a very relative concept.

Another issue with manual moderation is that the moderators become popular targets.  As soon as a moderator intervenes, the offender is angered and driven to become even more abusive, and they now aim these attacks directly at the moderator.  At Chesspark it took very little for these abusive people to direct their actions against our staff and volunteers.  We have had to ban hundreds of accounts (maybe thousands) with usernames like dandee_is_a_!@#, because, refusing to change their behavior, these users were first banned and then returned with moderator targetted attacks.

You also have the problem of training moderators in the community norms and preventing them from wielding their power abusively.  Chesspark spends quite a bit of time helping our volunteers learn the ropes.  I'd love to say we've never had to take away a volunteer's moderation rights, but unfortunately this happens on occasion.

<strong>Automated Moderation</strong>

When manual moderation didn't work for us, we decided to put our programming skills to the task.  We created a bot named RoboMom that sat in the official public channels and policed them for spamming and blacklisted words.

RoboMom employs a three strikes style policy.  On the first offense, the user is privately warned.  The second time they are kicked from the room.  This is a public action, but not a permanent one, and the user is free to re-join the room.  Unlike a private warning, being kicked from the room is very hard to ignore.  Finally, RoboMom will ban the user from the room for a set amount of time.  If the behavior continues, the bans double in length every time they are used.

The first thing we noticed about RoboMom is that she hardly ever banned anyone.  When we employed a similar policy enforced by humans, it was almost always the case that any interaction ended with a ban.  It turned out that having an automated robot and not a judgemental human did not anger or embarass the user.  This resulted in the user changing their behavior either after the warning or the room kick.

We also had to do a lot less work moderating rooms manually.  Instead, we could focus our efforts on helping users with problems, which is what we wanted to do in the first place.

<strong>Conclusion</strong>

I don't think anyone is going to conclusively solve this problem, but at least it can be helped.  Here are some tips distilled from the above:
<ul>
	<li>whitelisting is ineffective</li>
	<li>blacklisting can work ok if the list is small, and is nice as an optional setting for the user</li>
	<li>manual moderation makes moderators a target and does little to change user behavior, and meta-moderation becomes a necessity with volunteers</li>
	<li>automated moderation can result in modified user behavior, possibly because bots have no capacity to judge</li>
</ul>
I would love to hear from others about how you moderate your communities and whether those activities have been effective.

:EXTENDED:


