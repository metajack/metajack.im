---
layout: post
title: SRV Lookups In Erlang Part 2
tags: [code, dns, erlang]
time: "22:57"
extended: ":EXTENDED:"
---

Yesterday I [described](http://metajack.im/2008/10/30/srv-lookups-in-erlang/) the problems I had writing code to do DNS SRV lookups in [Erlang](http://www.erlang.org).  Today I'll describe how to use the code and also go through a few bits of it.



:EXTENDED:

## Using `srv.erl`

The `srv` mod exports a single function, `get_servers/4`.  It takes the service, the protocol, the domain, and a default port as arguments.  The service will be something like `xmpp-client` or `xmpp-server`.  The protocol is one of `tcp` or `udp`.  The final two arguments are self explanatory.

If for some reason there are no SRV records, `get_servers/4` will return a single response with the domain and default port.  This allows the module to be used even for non-SRV hosts like localhost.  This is just a useful convenience.

When there are SRV records, `srv` goes to the trouble to build an ordered list of results based on random selection of the answers.  It takes into account the weights and priorities assigned as well.  It return this ordered list, and you can attempt connections to each host and port pair until they all fail or one of them succeeds.

Here are two functions which show how this could be used.  They also show why Erlang's pattern matching is great.

    connect_xmpp_client(Domain) ->
        case srv:get_servers("xmpp-client", "tcp", Domain, 5222) of
            [] ->
                {error, no_servers};
            Servers ->
                try_connect(Servers)
        end.
    
    try_connect([{Host, Port} | Rest]) ->
        case gen_tcp:connect(Host, Port, [binary, {packet, 0}]) of
            {ok, _Socket} = R ->
                R;
            _ when size(Rest) =:= 0 ->
                {error, servers_exhausted};
            _ ->
                try_connect(Rest)
        end.

Call `connect_xmpp_client("jabber.org")` to open a socket to our favorite server.

## Examining `srv.erl`

The [code](http://metajack.im/code/srv.erl) is fairly simple, but I'd like to go through a few parts for those of you who might be interested in or already learning Erlang.

We use `inet_res/getbyname/2` to do the SRV lookup.  As I explained yesterday, this function is completely undocumented.  It is extremely simple to use as it returns a normal `hostent` record, except that the address list, `hostent.h_addr_list`, contains SRV results tuples.  These look like the example below.

    {Priority, Weight, Port, Host} = {5, 0, 5222, "talk.l.google.com"}

Using the address list, we can sort first by priority, then by weight.  We then pick a random entry of the lowest available priority by summing the weights, picking a random number between `0` and `sum - 1`, and then taking the first entry with a weight greater than or equal to our random number.  To build the entire list, we then remove the picked entry from the list, and pick again.  This is repeated until the original list is exhausted.

For those who might be new to Erlang, I'll show two of the functions here.  The first shows the idiomatic tail recursion with an accumulator which is the functional equivalent to the procedural for or while loop.

    do_sort([]) ->
        [];
    do_sort(AddrList) ->
        lists:reverse(do_sort(AddrList, [])).
    
    do_sort([], Acc) ->
        Acc;
    do_sort(AddrList, Acc) ->
        {ok, Pick, Rest} = pick_server(AddrList),
        do_sort(Rest, [Pick | Acc]).

`do_sort/1` just sets up the sort.  On an empty list, it returns an empty list.  For anything else it calls `do_sort/2` to do the actual work, then reverses the result.  The reverse is there because appending to a list is a linear time operation, while prepending is constant time.  Therefore, many algorithms will build up the list backwards and reverse it at the very end.

`do_sort/2` calls `pick_server/1` to pick a random entry and adds this entry onto the accumulator `Acc`.  Expressions like `[Head | Tail]` are essentially `cons` operations.  It adds `Head` to the front of the list `Tail`.  Finally we recurse with the rest of the list.  When `Rest` is the empty list, we just return the accumulator which contains the final result.

Note that we don't have to worry about smashing the stack with recursion here, as Erlang will optimize an isolated recursive call at the end of a function into a jump instruction.

Next we'll look at `pick_server/1`.

    pick_server(AddrList) ->
        Priority = element(1, lists:nth(1, AddrList)),
        List = lists:takewhile(fun ({P, _, _, _}) -> P == Priority end, AddrList),
        Pick = case List of
            [X] ->
                X;
            _ ->
                {Weighted, Sum} = lists:mapfoldl(
                    fun ({P, W, Port, Host}, Sum) ->
                         {{P, W, Port, Host, Sum + W}, 
                          Sum + W}
                    end, 0, List),
                R = random:uniform(Sum + 1) - 1,
                [Take | _]  = lists:dropwhile(fun ({_, _, _, _, S}) ->
                        S < R
                    end, Weighted),
                {Pri, Wgt, Prt, Hst, _} = Take,
                {Pri, Wgt, Prt, Hst}
            end,
        {_, _, Port, Addr} = Pick,
        {ok, {Addr, Port}, lists:delete(Pick, AddrList)}.

First we grab the first item's priority, which will be the lowest since it is pre-sorted.  Then we use `lists:takewhile/2` to grab all the items that have that priority.

If there is only one item, that's our pick.  Otherwise, we use `lists:mapfoldl/3` to sum the weights and return a new list where each item has the cumulative weight total as its last item.  If you've never seen a map, fold, or a mapfold, then the `lists` module [man page](http://www.erlang.org/doc/man/lists.html) has more information.

Now that we have this new list, the rest is easy.  We generate a random number, use `lists:dropwhile/2` to grab all the elements greater than or equal to the number, and take only the first element.  

The next two lines just decode the tuple and repack it into four elements.  The last two lines just grab the host and port, which are the only things we care about, and return the result and the original list minus the item we randomly selected.

## Functional Thoughts

It takes a little getting used to functional code, but once you get over the initial strangeness, it's quite simple and clear.  I'm enjoying programming in Erlang quite a lot, and I can see why so many people adore [Haskell](http://www.haskell.org), which has many things in common.
