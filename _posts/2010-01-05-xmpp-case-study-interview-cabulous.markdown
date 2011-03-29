---
layout: post
title: "XMPP Case Study Interview: Cabulous"
tags: [xmpp, jabber, case study, cabulous, mobile]
time: "15:22"
extended: ":EXTENDED:"
---

XMPP keeps showing up in new places and new applications. It is
amazing that the protocol is so versatile as to be used not only in
instant messaging applications, but also in domains like search, gaming,
middleware, and social services.

I want to highlight these developers and companies that are building
great things with XMPP. This is the first of a series of blog posts where
I'll interview the developers and let them explain their product and
how XMPP fits in. I hope you enjoy them! If you have suggestions for
future case study posts, please let me know.

Welcome to the first XMPP case study interview, with [Elijah
Windsor](http://twitter.com/ewindsor), lead developer of
[Cabulous](http://cabulous.com).

<p style='text-align: center'>
<img src='http://cabulous.com/wp-content/uploads/home-200x300.jpg'
width='200' height='300' alt='Cabulous screenshot'> <img
src='http://cabulous.com/wp-content/uploads/IMG_0090-200x300.PNG'
width='200' height='300' alt='Cabulous screenshot'>
</p>

:EXTENDED:

## Cabulous

<strong>Jack: What is Cabulous?</strong>

Elijah: Cabulous is a mobile application that gives taxi drivers and
their passengers peace of mind by seeing exactly where each other is
from hail to pick-up.

<strong>Jack: What platforms does Cabulous run on currently? Will it be expanding
 further?</strong>

Elijah: Currently it runs on the iPhone but we're soon going to be on
BlackBerry and Android.  Also we're coming out with a lite version
very soon for cab drivers who have a J2ME capable phone.

<strong>Jack: Where does XMPP fit in at Cabulous? What is it used for?</strong>

Elijah: XMPP is the protocol of choice for Cabulous.  We chose this protocol
because of it's flexibility and ease-of-use.  When you see cabs moving
around on your screen, that's done through XMPP.  When you hail a cab,
we use XMPP to let that cab driver know you want a ride.

<strong>Jack: Can users chat to the drivers? Are there other social features? Are
 these all done via XMPP as well?</strong>

Elijah: Currently the users can make phone calls to the drivers, but chat is
in the plans for the near future.  You can set a cabbie as your
favorite simply by clicking on the star next to his name.  This is
done through XMPP as a simple roster entry.  Then, later on you can
see if he's online, if he's available, and where he is simply by
clicking on his name in your favorites list.

<strong>Jack: Why did you choose XMPP for Cabulous?</strong>

Elijah: We wanted to use a protocol that allows for flexibility and
scalability.  We have experience using services such as polling on
HTTP for similar features as Cabulous, but this turned out to be nearly
unscalable.  XMPP is fast and gets the job done for us and allows us
to do more with less.

<strong>Jack: Were there alternative technologies that you investigated before
 choosing XMPP?</strong>

Elijah: Yes, one of the main ones we looked at as an alternative was AMQP.
But for the most part we were set on XMPP from the beginning.

<strong>Jack: Was this your first time working with the XMPP protocol?</strong>

Elijah: Yes.

<strong>Jack: Did it take you long to get up to speed? What parts excited you?
 Which parts gave you trouble?</strong>

Elijah: It didn't take too much time compared to other protocols out there.
For example with AMQP I would have to shift binary digits, and I
didn't want to do that.  The good thing about XMPP is it's XML so it's
very readable.

There are many books on XMPP and I chose one of the ones on
O'Reilly's Safari.  It helps me a great deal breaking down the 3 main
types of packets that are sent on XMPP.

<small>(The book Elijah references here is [XMPP: The Definitive Guide](http://www.amazon.com/dp/059652126X?tag=metajack-20).)</small>

One bit that caused a little trouble was finding the most reliable
XMPP server.  We went with Erlang's ejabberd and the hard part was
learning Erlang.  However now that that part's done with I am glad we
went with this server, and also might I add that Erlang is an awesome
language, and I'm glad we're where we are using it.

<strong>Jack: Was there anything that XMPP made simpler than it would otherwise be
 in Cabulous?</strong>

Elijah: Well for one, we didn't have to create our own system.  XMPP already
existed and was well defined before we came up with our idea.  And
also we enjoy seeing XML packets as they're a lot more readable than
some other methods.  That alone helped us out a great deal, and
another thing that helped us out a lot (and will help us out a lot in
the near future!) is scalability.

<strong>Jack: Did you need to define any custom protocols for your applicatoin, or
 did everything map into existing ones?</strong>

Elijah: Well, we understand that XMPP has been out for years and has been
tailored mainly to PCs over reliable Internet connections.  That being
said we, had to define several custom protocols (within XMPP standard
packet types) in order to accomodate the mobile network's limitations

We wanted our stuff to be fast and as close to one-step as it could
be for usability's sake.  So on some of our protocols we simply took
the existing XMPP ones and trimmed them down a bit.

<strong>Jack: Can you give an example of this?</strong>

Elijah: One example is the roster.  The standard XMPP example has us adding a
user to our roster, and then the user verifying that it's okay for us
to see their online status, and then the user who added the user can
see their friends online status.  We needed this to be a one-step
process as our situation is a bit different from a chatting program -
having cabbies verify passengers as OK to see them wouldn't make
sense, since cabbies want to be seen (and hailed!)

So we had to trim down the roster specification and ended up making
adding to to a roster a one-way, instant process.  Once you add
someone, you can see their online status and their location.

<strong>Jack: I assume you implemented this with custom ejabberd modules? Or did
 you modify the existing roster module to suit your needs?</strong>

Elijah: Custom ejabberd modules, yes.

<strong>Jack: That's a pretty major customization of XMPP logic. Was this difficult
 to do?</strong>

Elijah: It was difficult at first because of the limited resources about
ejabberd modules.  But once I got it to hook in right and was
comfortable with Erlang, it became easier.  A major strength here of
XMPP is that it's easy to read, so I didn't have to worry about
shifting bits around or anything like that.

<strong>Jack: Will you be using or recommending XMPP again in future projects?</strong>

Elijah: Definitely.  We will continue to expand upon our current set of
features for Cabulous and definitely use this for other location-based
social apps we create.

### Technical Details

Cabulous is a custom XMPP client. The current version is written in
Objective-C and uses the
[XMPPFramework](http://code.google.com/p/xmppframework/) library.

The XMPP server used is ejabberd, and the XMPP back-end consists a
mixture of normal ejabberd modules and some custom, Cabulous-specific
modules.

As a side note for Erlang fans, the web back-end for Cabulous is built
on top of [BeepBeep](http://github.com/davebryson/beepbeep) and
[MochiWeb](http://code.google.com/p/mochiweb/) and communicates with
the ejabberd server.

Elijah said that the social features of Cabulous mapped quite well
onto the standard roster functionality. The location information and
updates are implemented as a pubsub-like custom protocol that leverage
&lt;presence&gt; stanzas.

## My Thoughts

It's very cool to know that I can hail a cab with XMPP technology, but
most users do not care what powers the application. In this case, XMPP
is invisible to the end user. Those users will notice the
instantaneous updates they get and the social features XMPP has
enabled within the application.

You can download Cabulous today from iTunes; it's a free
application. I believe they've mostly been concentrating on cabs in
the San Francisco Bay area, but any cab driver can sign up and start
using it.

I wish Elijah and his team much luck with their application and their
further XMPP adventures!

