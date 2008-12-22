---
layout: post
title: "Writing Ejabberd Modules: Presence Storms"
tags: [code, ejabberd, erlang, jabber, module, presence, server, tutorial, xmpp]
time: "18:00"
extended: ":EXTENDED:"
---

<p>One of the biggest benefits to using <a href="http://www.ejabberd.im/">ejabberd</a> is the ease with which it is possible to extend the server's functionality.  After only a week of production operation, I've already written and deployed four new modules at <a href="http://www.chesspark.com/">Chesspark</a>.  Let's get our hands dirty, fire up an editor, and learn how to write a new ejabberd module.  Unlike most tutorials, the module created here is a real piece of code that we have running in production at Chesspark.</p>

<h2>Getting Started</h2>

<p>The code presented here is in Erlang, which is what ejabberd is written in.  If you are unfamiliar with Erlang, you will probably still be able to follow along just fine.  If you have a question about Erlang syntax or an Erlang function, the <a href="http://www.erlang.org/">Erlang Web site</a> has <a href="http://www.erlang.org/doc/getting_started/part_frame.html">tutorials</a> and <a href="http://www.erlang.org/doc/reference_manual/part_frame.html">reference documentation</a> for your enlightenment.  </p>

<p>Anders Conbere has written a series of excellent tutorials on writing ejabberd modules at <a href="http://anders.conbere.org/journal/">his blog</a>: <a href="http://anders.conbere.org/journal/building-ejabberd-modules-part-1-compiling-erlang/">building ejabberd</a>, <a href="http://anders.conbere.org/journal/building-ejabberd-modules-part-2-generic-modules/">writing a generic module</a>, <a href="http://anders.conbere.org/journal/building-ejabberd-modules-part-3-http-modules/">writing an HTTP module</a>, and <a href="http://anders.conbere.org/journal/building-ejabberd-modules-part-4-xmpp-bots/">writing an XMPP bot module</a>.  I will assume that that you have read at least his tutorial on <a href="http://anders.conbere.org/journal/building-ejabberd-modules-part-2-generic-modules/">generic modules</a>.</p>

<p>Finally, there is some incomplete documentation about <a href="http://www.process-one.net/en/wiki/ejabberd_module_development/">developing ejabberd modules</a> in the <a href="http://www.process-one.net/en/wiki/ejabberd/">ejabberd wiki</a>.</p>

<h2>Stopping Storms With A Little mod_sunshine</h2>

<p>During our <a href="http://metajack.im/2008/08/27/migrating-to-ejabberd-the-gory-details/">ejabberd migration</a>, we ran into a bug in our desktop client that caused it to send the same presence stanza over and over in an infinite loop.  While providing an updated build of the client solved the problem for many of our users, some users refused to upgrade.  Not only did this cause a lot of undue stress on our XMPP server, it also affected all of the broken client's user's online contacts.  These presence storms were silently degrading the service quality for nearly everyone.</p>

<p>We decided that the best solution would be to detect presence storms and disconnect the offending clients.  This required writing a fairly simple ejabberd module that I named mod_sunshine.  We'll recreate the same code here.</p>

<h2>mod_sunshine's Humble Beginnings</h2>

<p>Every ejabberd module implements the <tt>gen_mod</tt> behavior.  An Erlang behavior is just a set of functions that a module implementing the behavior is required to support.  The <tt>gen_mod</tt> behavior requires two functions: <tt>start/2</tt> and <tt>stop/1</tt>.  These functions are called when ejabberd starts and stops the module.</p>

<p>The skeleton of an ejabberd module appears below.</p>

<div style="border:1px solid black;color:#660034;overflow:auto;padding:5px 25px;"><pre>
-module(mod_sunshine).

-behavior(gen_mod).

-export([start/2, stop/1]).

start(_Host, _Opts) -&gt;
    ok.

stop(_Host) -&gt;
    ok.
</pre></div>

<p>For those of you wondering, the preceding underscores on the function arguments signal to the Erlang compiler that these arguments are unused.</p>

<p>This code should be placed in a file called <tt>mod_sunshine.erl</tt>.  Assuming you have Erlang and ejabberd somewhere on your system, you can compile <tt>mod_sunshine.erl</tt> with this command: <tt>erlc -I /path/to/src_or_include -pz /path/to/src_or_ebin mod_sunshine.erl</tt>.</p>

<p>This module can be added to the server by adding a line like the one below to the server configuration.  You'll also need to place the module's <tt>.beam</tt> file in the ejabberd <tt>ebin</tt> directory alongside the rest of ejabberd's <tt>.beam</tt> files.</p>

<div style="border:1px solid black;color:#660034;overflow:auto;padding:5px 25px;"><pre>
{mod_sunshine, []}
</pre></div>

<h2>Hooks, Hooks, and More Hooks</h2>

<p>ejabberd modules extend functionality of the server by connecting themselves to hooks.  A hook is just a place in the code where ejabberd offers a connection point.  There are hooks for when a user sends a packet or receives a packet, for when sessions are created or removed, and for many other things.  A list of hooks can be found in the <a href="http://www.process-one.net/en/wiki/ejabberd_events_and_hooks/">ejabberd events and hooks documentation</a>.</p>

<p>Each hook in ejabberd is associated with a chain of functions to execute.  ejabberd modules will add functions to these chains, and when the hook is triggered, the chain of functions is executed.  Each function has a priority in the chain, and ejabberd will execute them in order.  Additionally, it is possible for a function to terminate the hook processing so that later functions in the chain do not get executed.</p>

<p>ejabberd modules typically add some functions to one or more of these hook chains and then wait around for them to be executed.  This is very similar to GUI code where one responds to input events, only instead of mouse clicks and keyboard presses, modules will respond to packets being sent or users coming online.</p>

<p>Just to make sure you fully understand the hook processing and the function chains, let's go through an example.</p>

<h2>Passing Around Offline Messages</h2>

<p>When a message comes into an ejabberd server for a user that is currently offline, ejabberd executes the chain of functions for the hook <tt>offline_message_hook</tt>.</p>

<p>The ejabberd session manager adds a default function to the <tt>offline_message_hook</tt> chain that bounces the incoming message with a service unavailable error.  This hook is added at the lowest priority so that it executes after anything else in the chain.</p>

<p>The <tt>mod_offline</tt> module, which comes with ejabberd, uses this same hook to add support for storing offline messages in a database.  These messages are then sent to a user when they next come online.  It does this by adding a function to the chain at a higher priority than the session manager's.  When a message gets sent to an offline user, this function executes first and stores the message in the database.  Since it would be silly to return an error now that the message has been stored, <tt>mod_offline</tt>'s function signals to the hook processor that no more functions should be run in this chain.  The session manager's default function will never be executed.</p>

<p>At Chesspark we generate a lot of messages that are meaningless if they are not delivered to someone while they are online.  We built a module that filters offline messages and discards those that are inappropriate for database storage.  This works by adding a function to the <tt>offline_message_hook</tt> chain at a very high priority.  This means that our function is the first function to receive the message sent to an offline user.  If the module determines the message is inappropriate for storage, we signal to the hook processor that it should not continue executing chain functions, silently dropping the message.  Otherwise, the module let's the rest of the chain execute normally, which means that <tt>mod_offline</tt>, which is next in the chain, will receive the message and store it.</p>

<h2>Hooking Presence For mod_sunshine</h2>

<p>Now that we know a lot about hooks and hook processing, it's time to put it to some use in <tt>mod_sunshine</tt>.  First, we have to know which hook to use.</p>

<p>Unfortunately, none of the documentation is very clear about which hooks are executed at what times.  I have found that experimentation is the only way to figure this out.  Use the name of the hooks to make a guess, and then use some logging statements to figure out if that hook gets run when you expect.  You can also search for the hook's name in the ejabberd source code to find out when it is executed and what is expected of the functions in the chain.</p>

<p>For <tt>mod_sunshine</tt>, the hook we are interested in is <tt>set_presence_hook</tt>.  This hook is processed whenever a connected user sends a presence stanza to the server.  It's common to add a function to the chain in <tt>start/2</tt> and remove the same function in <tt>stop/1</tt>, and that's what we've done below.  Additionally, we must export the function we wish to add.</p>

<div style="border:1px solid black;color:#660034;overflow:auto;padding:5px 25px;"><pre>
-module(mod_sunshine).

-behavior(gen_mod).

-export([start/2, stop/1, on_presence/4]).

start(Host, _Opts) -&gt;
    ejabberd_hooks:add(set_presence_hook, Host, ?MODULE, on_presence, 50),
    ok.

stop(Host) -&gt;
    ejabberd_hooks:delete(set_presence_hook, Host, ?MODULE, on_presence, 50),
    ok.

on_presence(_User, _Server, _Resource, _Packet) -&gt;
    none.
</pre></div>

<p>A function in the <tt>set_presence_hook</tt> chain takes four parameters: the user, server, and resource of the person that sent the presence stanza as well as the actual presence stanza.  It is required to return <tt>none</tt>.</p>

<h2>A Module That Does Nothing Is Hardly A Module At All</h2>

<p>So far we have a module that doesn't almost nothing.  It adds a function to the <tt>set_presence_hook</tt> chain when it is loaded, removes the function from the chain when it is unloaded, and does absolutely nothing when the chain is executed.  It's time to get to the meat of the module.</p>

<p>First, <tt>mod_sunshine</tt> needs to know what a presence storm is.  We can define this as a user sending the same presence stanza <tt>count</tt> times in <tt>interval</tt> seconds.  Since we might not know what the optimal values are for <tt>count</tt> and <tt>interval</tt>, it is best to leave those as options to be defined in the ejabberd configuration file.</p>

<p>Next, the module needs to store its state somewhere so it can check if a user is sending a presence storm.  Since ejabberd passes no state to <tt>on_presence/4</tt>, we must keep track of this ourselves.  We'll do this with mnesia, one of Erlang's built in databases.</p>

<p>Finally, the module needs to disconnect any user who causes a presence storm.  Unfortunately, ejabberd does not seem to have an API or message for this out of the box, so we will have to add this ourselves to the internal ejabberd c2s module.</p>

<h2>Intermission And Logging</h2>

<p>It's time for a small break before we dive into the real code, so let's digress for a second and talk about logging.</p>

<p>It will probably happen in your Erlang programming career that something goes wrong and you can't figure out what that something is.  A time honored tradition exists for exactly these situations - printing some information to a log file.</p>

<p>Should you need to do this, ejabberd has several macros for writing to its log file at different logging levels.  They are defined in <tt>ejabberd.hrl</tt> which you will have to include in the code to use them.  I usually prefer to use <tt>?INFO_MSG</tt>.  These functions take a string followed by a list of arguments.  Be sure to remember that you must pass an empty list if there are no arguments.</p>

<p>Here's <tt>mod_sunshine.erl</tt> from before with modifications to announce its startup and shutdown.</p>

<div style="border:1px solid black;color:#660034;overflow:auto;padding:5px 25px;"><pre>
-module(mod_sunshine).

-behavior(gen_mod).

-include("ejabberd.hrl").

-export([start/2, stop/1, on_presence/4]).

start(Host, _Opts) -&gt;
    ?INFO_MSG("mod_sunshine starting", []),
    ejabberd_hooks:add(set_presence_hook, Host, ?MODULE, on_presence, 50),
    ok.

stop(Host) -&gt;
    ?INFO_MSG("mod_sunshine stopping", []),
    ejabberd_hooks:delete(set_presence_hook, Host, ?MODULE, on_presence, 50),
    ok.

on_presence(_User, _Server, _Resource, _Packet) -&gt;
    none.
</pre></div>

<p>Ok, break time is over; let's get back to the real stuff.</p>

<h2>Dealing With Options</h2>

<p>To pass options to <tt>mod_sunshine</tt> we have to change the ejabberd configuration file.  The line we used above should be modified to the one below.</p>

<div style="border:1px solid black;color:#660034;overflow:auto;padding:5px 25px;"><pre>
{mod_sunshine, [{count, 10}, {interval, 60}]}
</pre></div>

<p>This will tell <tt>mod_sunshine</tt> that a presence storm is anyone sending 10 copies of the same presence stanza within 60 seconds.  Now we just need to get these options into the code.</p>

<p>Alert readers will notice that while <tt>start/2</tt> is passed the options in the <tt>Opts</tt> variable, the <tt>on_presence/4</tt> function does not receive these.  How are we to get the options?</p>

<p>Thankfully, <tt>gen_mod</tt> has an API function to fetch the module options from the configuration - <tt>gen_mod:get_module_opt(Host, Module, Opt, Default)</tt>.  This function needs the virtual host the options are defined for.  This just happens to be the contents of the <tt>Server</tt> variable in <tt>on_presence/4</tt>.  <tt>gen_mod:get_module_opt/4</tt> also lets you define the default option values.</p>

<p>Adding options to <tt>mod_sunshine</tt> is now easy.</p>

<div style="border:1px solid black;color:#660034;overflow:auto;padding:5px 25px;"><pre>
-module(mod_sunshine).

-behavior(gen_mod).

-include("ejabberd.hrl").

-export([start/2, stop/1, on_presence/4]).

start(Host, _Opts) -&gt;
    ?INFO_MSG("mod_sunshine starting", []),
    ejabberd_hooks:add(set_presence_hook, Host, ?MODULE, on_presence, 50),
    ok.

stop(Host) -&gt;
    ?INFO_MSG("mod_sunshine stopping", []),
    ejabberd_hooks:delete(set_presence_hook, Host, ?MODULE, on_presence, 50),
    ok.

on_presence(_User, Server, _Resource, _Packet) -&gt;
    %% get options
    StormCount = gen_mod:get_module_opt(Server, ?MODULE, count, 10),
    TimeInterval = gen_mod:get_module_opt(Server, ?MODULE, interval, 60),
    none.
</pre></div>

<h2>Persisting State With Mnesia</h2>

<p>Mnesia is easiest to use when paired with Erlang records.  For the Erlang beginners, Erlang records are like C structs.  They are normal Erlang tuples with named fields.  We'll need to create a record for <tt>mod_sunshine</tt> to store the user, packet, the time the packet was originally sent, and the number of times the packet has been sent.  Here's what that looks like.</p>

<div style="border:1px solid black;color:#660034;overflow:auto;padding:5px 25px;"><pre>
-record(sunshine, {usr, packet, start, count}).
</pre></div>

<p>The name of the record is <tt>sunshine</tt>.  Note that the first of the four fields is not a typo of 'user'.  It is an acronym for 'user, server, resource' and will store the full JID of the user sending presence.</p>

<h2>Creating Mnesia Tables</h2>

<p>Now that we have a record, we must create an Mnesia table to use them.  Each row of the Mnesia table will be in this format, and the key is the first item of the record, <tt>usr</tt>.  <tt>mnesia:create_table/2</tt> does the job for us.  Mnesia can create various kinds of tables - disk tables, memory tables, and tables that allow duplicates.  By default it creates an in-memory, unsorted table that does not allow duplicate keys, and this happens to be exactly what we want.  The <a href="http://www.erlang.org/doc/man/mnesia.html">Mnesia man page</a> has information on other table types if you are interested.</p>

<p>We'll create and clear this table in <tt>start/2</tt>.</p>

<div style="border:1px solid black;color:#660034;overflow:auto;padding:5px 25px;"><pre>
start(Host, _Opts) -&gt;
    ?INFO_MSG("mod_sunshine starting", []),
    mnesia:create_table(sunshine, 
            [{attributes, record_info(fields, sunshine)}]),
    mnesia:clear_table(sunshine),
    ejabberd_hooks:add(set_presence_hook, Host, ?MODULE, on_presence, 50),
    ok.
</pre></div>

<p>The first argument to <tt>mnesia:create_table/2</tt> is the name of the table, which must be the same as the record name.  This is followed by a list of options, of which we only use <tt>attributes</tt>.  <tt>record_info(fields, sunshine)</tt> is a built in function of Erlang that returns a list of the fields in the record <tt>sunshine</tt>.  Mnesia won't destroy an existing table if you call <tt>create_table/2</tt>, so to make sure there isn't any old data in there we use <tt>mnesia:clear_table/1</tt>.</p>

<h2>Reading And Writing To The Database</h2>

<p>Mnesia is a transactional database.  To read and write to it, one normally uses <tt>mnesia:transaction/1</tt> which takes a function to execute inside the transaction.  This can be slow, so often <tt>mnesia:dirty_read/2</tt> is used to skip transactions for reads, and we will use that here.</p>

<p>In order to keep the user, server, and resource key consistent, we must stringprep the username and server.  Among other things, this ensures that mixed case usernames get lower cased.  This is easy in ejabberd since it provides a library of functions for JID manipulation called <tt>jlib</tt>.  To use it, we include <tt>jlib.hrl</tt> in our module.</p>

<p>Once we have a consistent key, we look it up in the <tt>sunshine</tt> table.  There are three possibilities:  no record is found, a record is found for the current packet, or a record is found for a different packet.</p>

<p>The skeleton for this is below.</p>

<div style="border:1px solid black;color:#660034;overflow:auto;padding:5px 25px;"><pre>
on_presence(User, Server, Resource, Packet) -&gt;
    %% get options
    StormCount = gen_mod:get_module_opt(Server, ?MODULE, count, 10),
    TimeInterval = gen_mod:get_module_opt(Server, ?MODULE, interval, 60),

    LUser = jlib:nodeprep(User),
    LServer = jlib:nodeprep(Server),

    case catch mnesia:dirty_read(sunshine, {LUser, LServer, Resource}) of
        [] -&gt;
            %% no record for this key
            ok;
        [#sunshine{usr={LUser, LServer, Resource}, 
                   packet=Packet, start=_TimeStart, count=_Count}] -&gt;
            %% record for this key and packet exists
            ok;
        [#sunshine{usr={LUser, LServer, Resource},
                   packet=_OtherPacket, count=_OtherCount}] -&gt;
            %% a record for this key was found, but for another packet
            ok
    end,
    none.
</pre></div>

<p>Those new to Erlang are probably a little weirded out right now.  Erlang uses pattern matching extensively.  First we read from the database, and attempt to match the pattern of the result against each section of the <tt>case</tt> statement.  If a variable in the pattern already contains a value, it must match the value in the result.  If a variable in the pattern does not have a value, it gets the value of the result in that spot.</p>

<p>If we get an empty list, there is no record matching the key.  Note that we get a list as a result because some Mnesia table types support duplicate keys.  In our table, the result will always be an empty list or a list with one item.</p>

<p>The next two patterns match a row.  <tt>#sunshine{...}</tt> is a record reference for the <tt>sunshine</tt> record.  In the first of the two patterns, all the variables have values except for <tt>_TimeStart</tt> and <tt>_Count</tt>.  This means the result must be a record that matches the record for this user and this packet.  The second pattern matches a record for this user, but with any packet, as <tt>_OtherPacket</tt> is without a value.</p>

<p>Pattern matching is nice and powerful.  Not only did we single out exactly the results we needed without any if statements, we also already put the interesting fields into their own variables!</p>

<p>Now we just need to code the actions for each of these three cases.</p>

<p>In the first case, we create a new entry for that user and packet.</p>

<p>In the second case, we need to determine we're within <tt>TimeInterval</tt> seconds of <tt>StartTime</tt>.  If not, we need to reset the count and start time for this user and packet.  Otherwise, if the count is above <tt>StormCount</tt>, the user is sending a presence storm and needs to be disconnected, and if the count is below <tt>StormCount</tt> we just increment the count.</p>

<p>In the final case, we've received a different presence packet, so we need to overwrite the user's record in Mnesia with a new one for this packet.</p>

<p>Remember that Mnesia writes happen inside transactions as you look at the code below.  The writes are put into anonymous functions which are then passed to <tt>mnesia:transaction/1</tt> for execution inside a transaction.</p>

<div style="border:1px solid black;color:#660034;overflow:auto;padding:5px 25px;"><pre>
on_presence(User, Server, Resource, Packet) -&gt;
    %% get options
    StormCount = gen_mod:get_module_opt(Server, ?MODULE, count, 10),
    TimeInterval = gen_mod:get_module_opt(Server, ?MODULE, interval, 60),

    LUser = jlib:nodeprep(User),
    LServer = jlib:nodeprep(Server),

    {MegaSecs, Secs, _MicroSecs} = now(),
    TimeStamp = MegaSecs * 1000000 + Secs,

    case catch mnesia:dirty_read(sunshine, {LUser, LServer, Resource}) of
        [] -&gt;
            %% no record for this key, so make a new one
            F = fun() -&gt;
                mnesia:write(#sunshine{usr={LUser, LServer, Resource},
                                       packet=Packet,
                                       start=TimeStamp,
                                       count=1})
            end,
            mnesia:transaction(F);
        [#sunshine{usr={LUser, LServer, Resource}, 
                   packet=Packet, start=TimeStart, count=Count}] -&gt;
            %% record for this key and packet exists, check if we're
            %% within TimeInterval seconds, and whether the StormCount is
            %% high enough.  or else just increment the count.
            if
                TimeStamp - TimeStart &gt; TimeInterval -&gt;
                    F = fun() -&gt;
                        mnesia:write(#sunshine{usr={LUser,
                                                    LServer,
                                                    Resource},
                                               packet=Packet,
                                               start=TimeStamp,
                                               count=1})
                    end,
                    mnesia:transaction(F);
                Count =:= StormCount -&gt;
                    %% TODO: disconnect user

                    F = fun() -&gt;
                        mnesia:delete({sunshine, {LUser, LServer, 
                                                  Resource}})
                    end,
                    mnesia:transaction(F);
                true -&gt;
                    F = fun() -&gt;
                    mnesia:write(#sunshine{usr={LUser, LServer,
                                                   Resource},
                                              packet=Packet,
                                              start=TimeStamp,
                                              count=Count + 1})
                    end,
                    mnesia:transaction(F)
            end;
        [#sunshine{usr={LUser, LServer, Resource},
                   packet=_OtherPacket, count=_OtherCount}] -&gt;
            %% a record for this key was found, but for another packet,
            %% so we replace it with a new record.
            F = fun() -&gt;
                mnesia:write(#sunshine{usr={LUser, LServer, Resource},
                                       packet=Packet,
                                       start=TimeStamp,
                                       count=1})
            end,
            mnesia:transaction(F)
    end,
    none.
</pre></div>

<h2>Disconnecting Users</h2>

<p>The only thing left to do is disconnect the user when a presence storm is detected.  I wish this was as easy as <tt>ejabberd_sm:disconnect(User, Server, Resource)</tt>, but it seems that the ejabberd developers have not yet added something along these lines.  To solve this, we will use Erlang's message passing to notify the user's c2s process that it should disconnect the user.</p>

<p>After some exploring, I discovered you can get the c2s process identifier for a given user by calling <tt>ejabberd_sm:get_session_pid/3</tt> which takes the user, server, and resource.  Once we know the process identifer, we can send it a message with Erlang's <tt>!</tt> operator.  </p>

<p>First let's finish out <tt>on_presence/4</tt> by replacing the placeholder comment with the <tt>disconnect</tt> message to the c2s process for the user, shown below.</p>

<div style="border:1px solid black;color:#660034;overflow:auto;padding:5px 25px;"><pre>
%% disconnect the user
SID = ejabberd_sm:get_session_pid(LUser, LServer, Resource),
SID ! disconnect,
</pre></div>

<p>Our module is now finished, except that the c2s process will not understand our message.  We'll have to provide a new message handler for the <tt>disconnect</tt> message in <tt>ejabberd_c2s.erl</tt>.  Add the following clause to <tt>handle_info/3</tt> in <tt>ejabberd_c2s.erl</tt>.</p>

<div style="border:1px solid black;color:#660034;overflow:auto;padding:5px 25px;"><pre>
handle_info(disconnect, _StateName, StateData) -&gt;
    send_text(StateData, ?STREAM_TRAILER),
    {stop, normal, StateData};
</pre></div>

<p>You can insert this clause before the first <tt>handle_info/3</tt> clause.  Just search <tt>ejabberd_c2s.erl</tt> for <tt>handle_info</tt>, and when you find the function definition, just paste this code immediately before it, but after the function's comment.</p>

<p>Now you must recompile ejabberd and restart the server.  If you know what you are doing, you can load this patch into the server while it is running.  We did this at Chesspark to avoid taking the server down.  This is another beautiful feature of ejabberd.</p>

<h2>mod_sunshine In Action</h2>

<p>We're all finished, and <tt>mod_sunshine</tt> can be deployed to stop the evil presence storms.  To test that it works, just send the same presence stanza a bunch of times, really fast.  You will find yourself quickly disconnected.  You will probably need to write a quick test client for this as you might not be able to trigger duplicate presence with your normal XMPP client.  I highly recommend <a href="http://code.stanziq.com/strophe">Strophe.js</a> for this task.</p>

<p>I hope that this tutorial has been helpful to you, and that you use this knowledge only for good.  Go have fun implementing your wild and crazy ideas for server modules!  If you have any suggestions and questions, please let me know in the comments.</p>

<p>The full source of <tt>mod_sunshine.erl</tt> is available <a href="http://people.chesspark.com/~jack/mod_sunshine.erl">here</a>.</p>



:EXTENDED:


