---
layout: post
title: Strophe.js Community Plugins Project
tags: [strophe, javascript, xmpp]
time: "15:12"
extended: ":EXTENDED:"
---

The community has been doing great work on Strophe.js plugins, but for
the most part, this work has remained invisible. I want to change
that.

I have created the
[strophejs-plugins](https://github.com/metajack/strophejs-plugins)
repository on GitHub and moved everything but the
[flXHR](http://flxhr.flensed.com/) plugin into this new repository. My
plan is for this to be the clearing house for community plugins.

If you want to add a new plugin or contribute to an existing one,
please fork this repository and send me a pull request. I will not be
nearly as picky about commits to strophejs-plugins as I am with the
main Strophe.js code, but I expect as plugins mature, a higher bar
will be created for those specific plugins.

Within a few hours, the first community plugin was added to the
repository, the
[serverdate](https://github.com/metajack/strophejs-plugins/tree/master/serverdate/)
plugin, which detects clock skew between the client and server. I know
there are some excellent plugins out there, so don't be shy - fork and
hack!
