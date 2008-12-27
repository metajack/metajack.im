---
layout: post
title: "The Not So Great Debate: Addressing Schemes"
tags: [addressing, dns, federation, jabber, omb, openmicroblogging, srv, xmpp]
time: "13:12"
extended: ":EXTENDED:"
---

In a federated network addressing becomes more complex than simply referring to a username.  There are lots of schemes for addressing, and this has become a hot topic in the OpenMicroblogging world ever since it was [discussed at BearHugCamp](http://metajack.im/2008/09/13/bearhugcamp-for-those-who-missed-it/).  Part of the debate is pointless since it boils down to aesthetics, and part of it is serious business.  Will we make use of the tools already available or should we invent something new?

:EXTENDED:

## User Versus Protocol

There are two areas in which the debate rages.  In one area, the question is how can users disambiguate @-replies.  The other area is how to represent the canonical address of a given person.

### @-Replies

So far most of the debate has been about @-replies.  People have already adopted the format "@user" to address a specific user.  This works great on Twitter where there is no federation, but once you have more sites, this becomes potentially ambiguous.

For federation, some have suggested schemes like '@user@domain', '@user/domain', '@user:domain', 'domain@user', etc.  

There are two reasons why this is even being discussed at all.  The first is that something low inpact is needed over SMS so as to not take up the bulk of the 140 characters available.  This is easily solvable with short names which are mapped via DNS to full domains.  For example, given metajack@twit, a lookup to twit.shortname.openmicroblogging.org could return a CNAME record of 'twitter.com'.  

The second reason is that the obvious solution here of user@domain is claimed to be ugly.  '@user@domain' may not be the prettiest thing ever, but neither is 'http://' and that has suited everyone just fine for years now.   The beauty pageant will turn into a religious war of preference.

Personally, I'm in favor of the short name system regardless of what separator is used for it.  However, I also think we should go with the flow of '@' as a separator because that is what people are already familiar with as users of the loosely federated e-mail system.

### Canonical Address

The debate over canonical addresses comes down to whether the address should be in the form 'user@domain' or the URL of the person's profile, such as 'http://twitter.com/user'.

I think using URLs is sort of silly, because each microblogging site may have its own URL structure, and this means that canonical addresses will be in a hundred different formats.  Exposing this to the user is just terrible; they will have to know which domains have which paths.   What happens when the first clueless implementor gives every profile a URL that isn't RESTful?  

> Hello, @facebook/profile.php?id=787072867!  My what a lovely name you have!

I think the addressing should piggyback on the DNS system for resolving such canonical addresses.  SRV records already provide an excellent way to query for services on a domain; XMPP uses this to find how to talk to servers on the federated network.  A mapping to URLs can be pointed to by TXT records providing an easy way to find someone's canonical profile URL from their address.  Users never get exposed to the details and can use a simple, familiar addressing scheme.

One argument for URLs is that user's are already familiar with them as identities from social networking sites.  I think this isn't really true.  The Facebook profile URL (see above) is quite opaque and not something anyone really associates with themselves except via HTML link mapping.  I believe most people refer to themselves as "metajack on twitter" or "Jack Moffitt on Facebook".  Even these services themselves use e-mail addresses for friend discovery.

Another argument for URLs is to support multiple microblogging installations under a single domain.  I don't think this argument is strong enough to warrant abandoning the current infrastructure the Internet provides and creating something new.  It's easy enough to use sub-domains for this purpose, and short names can still hide the dot notation from the end user.  For example, 'metajack@devi' can resolve to 'metajack@dev.identi.ca'.

### More On Short Names 

Another benefit of short names is that they work both ways.  If a user does not know the short name, the server can just substitute it much like Twitter automatically substitutes long URLs with TinyURLs.  This means users need learn nothing, although many will pick up the habit by example.

One complaint about short names is that it requires a centralized mapping.  This isn't really much of a problem.  Organizations like the IETF and XSF are quite good at maintaining such mappings.  If we need an OpenMicroblogging standards body, so be it.  Also, as long as full addressing still works, short names are just an optimization.

## These Systems Are Solved Problems

There will be people who equate my support of 'user@domain' and '@' as a separator as being related to my support of XMPP.  While XMPP does use this scheme, it did not invent it.  XMPP adopted this scheme from e-mail and other Internet standards where this problem had already been successfully addressed.  I'll note also that XMPP makes heavy use of URIs for various purposes where they make sense.

This is the addressing scheme of the Internet, for better or worse.  Even HTTP uses 'user@domain' when usernames are required.  I see know reason to go against the flow of every other protocol just to get something that is a little more aesthetically pleasing.


