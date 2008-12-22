%% srv.erl

-module(srv).
-author("Jack Moffitt <jack@metajack.im>").

-include_lib("kernel/include/inet.hrl").

-export([get_servers/4]).

do_query(Service, Proto, Domain, DefaultPort) ->
    Name = "_" ++ Service ++ "._" ++ Proto ++ "." ++ Domain,
    FakeHEnt = #hostent{h_name=Name,
			h_aliases=[],
			h_addrtype=srv,
			h_length=1,
			h_addr_list=[{0, 0, DefaultPort, Domain}]},
    Res = case inet_res:getbyname(Name, srv) of
	      {error, _} ->
		  %% srv lookup failed, fake it with DefaultPort and Domain
		  %% to handle cases like localhost
		  {ok, FakeHEnt};
	      {ok, _} = R ->
		  R
	  end,
    case Res of
	{error, _} = E ->
	    E;
	{ok, HEnt} ->
	    case HEnt#hostent.h_addr_list of
		[] ->
		    [{0, 0, DefaultPort, Domain}];
		AddrList ->
		    lists:sort(fun ({PriorityA, WeightA, _, _}, 
				    {PriorityB, WeightB, _, _}) ->
				       if 
					   PriorityA < PriorityB ->
					       true;
					   WeightA < WeightB, 
					   PriorityA =:= PriorityB ->
					       true;
					   true ->
					       false
				       end
			       end, AddrList)
	    end
    end.

get_servers(Service, Proto, Domain, DefaultPort) ->		  
    {S1, S2, S3} = now(),
    random:seed(S1, S2, S3),
    AddrList = case do_query(Service, Proto, Domain, DefaultPort) of
		   {error, _} ->
		       [];
		   L ->
		       L
	       end,
    do_sort(AddrList).
	      
do_sort([]) ->
    [];
do_sort(AddrList) ->
    lists:reverse(do_sort(AddrList, [])).

do_sort([], Acc) ->
    Acc;
do_sort(AddrList, Acc) ->
    {ok, Pick, Rest} = pick_server(AddrList),
    do_sort(Rest, [Pick | Acc]).

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
