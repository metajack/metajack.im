---
layout: post
title: File Descriptors are Yummy or Common Pitfalls of Ejabberd
tags: [ejabberd, erlang, jabber, linux, xmpp]
time: "20:40"
extended: ":EXTENDED:"
---

Erlang is different - really different.  Most people coming to Erlang for the first time don't realize that it is designed to host lots of lightweight processes that communicate via message passing.  Even those that do know about this underestimate "lots" by an order of magnitude.  Erlang can host hundreds of thousands of processes, and one consequence of this is that Erlang loves to eat file descriptors.   This has tripped up many first time users of ejabberd, and it's time someone explained how to deal with this.

:EXTENDED:

## How Many Processes Does It Take To Talk XMPP?

In ejabberd, each client connection is a process, each server connection is a process, and processes are used to parallelize stanza handling in certain cases.  This can start to add up.  Just as an example, [Chesspark](http://www.chesspark.com) currently has 663 processes running and [jabber.org](http://www.jabber.org) has over 22 thousand.

This sounds like a lot, and compared to languages most of us are used to it is.  You shouldn't be alarmed by this however; it's just how Erlang was designed.  All these processes can quickly start consuming a lot of file descriptors, and this is where things start to go wrong.

## 1024 File Descriptors Should Be Enough For Everyone

Most operating systems of the Unix lineage give users a maximum of 1024 file descriptors to play with.  Normally this is plenty.  With Erlang, this limit soon becomes constricting.

The normal way to fix this is to increase the file descriptor limit.  The `ulimit` command will describe the current limits for the current shell, and `ulimit -n NUM` will request a new limit of `NUM` file descriptors.  On typical machines doing this as a normal user will fail.  Not only that but if you raise the limit as root and then launch ejabberd, which is run via `su`, the new shell will not inherit the limit.  What to do?

### Linux Systems

On Linux it is necessary to increase the default allowed for a single user.  This can be done by editing `/etc/security/limits.conf` and adding lines like these:

    # Allow the jabber user to open lots of files/sockets
    jabber           hard    nofile          30000
    jabber           soft    nofile          30000

You will also need to make sure that these limits are respected by PAM.  Take a look through `/etc/pam.d/login` and `/etc/pam.d/su` and make sure that the following line is uncommented.

    session    required   pam_limits.so

This seems to be commented out by default on most Linux machines.

With those changes the jabber user can now open 30,000 file descriptors.  ejabberd proably won't use that many, but better safe than sorry.

### Mac OS X Systems

OS X systems are a little easier.  The `sysctl` command controls these limits and you can set `kern.maxfiles` and `kern.maxfilesperproc` to whatever levels you need.  For example:

    sudo sysctl -w kern.maxfiles=65536
    sudo sysctl -w kern.maxfilesperproc=30000

To make such changes permanent add some lines to `/etc/sysctl.conf`

    kern.maxfiles=65536
    kern.maxfilesperproc=30000

## Don't Be Embarassed; Even We Messed This Up

Running out of file descriptors has bitten many a systems administrator.  Even the jabber.org team bumped into this issue when ejabberd was put into production.  I hit it myself testing ejabberd for Chesspark, and now [Identi.ca](http://identi.ca) has been similarly bitten.  I suppose it's a right of passage.

While Erlang certainly helps eat file descriptors, I think the real issue is that XMPP daemons just need a lot of sockets, which just happen to be file descriptors.  After all, no matter what language you use, you need one socket per connected client and one per federated server with whom you are communicating.  Even if you don't have many local users, there are a lot of XMPP servers out there.

This is a lot different than most Web servers which only need to handle a relatively small amount of simultaneously connected users, but very high traffic Web sites will also run into file descriptor shortages.

So don't feel bad when you've run into this problem and found this blog entry about how to fix it.  We all know your pain, and we're here to make it all better.  Your shiny new XMPP server is well worth it.
