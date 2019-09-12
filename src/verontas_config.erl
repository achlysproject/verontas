%%%-------------------------------------------------------------------
%%% @author Igor Kopestenski
%%% 2019, <UCLouvain>
%%% @doc
%%%
%%% @end
%%% Created : 12. Sep 2019 17:05
%%%-------------------------------------------------------------------
-module(verontas_config).

%% API
-export([get/1]).
-export([get/2]).
-export([set/2]).

%% @equiv application:get_env(verontas, Key)
-spec get(atom()) -> undefined|{ok , term()}.
get(Key) ->
    application:get_env(verontas , Key).

%% @equiv application:get_env(verontas, Key, Default)
-spec get(atom() , term()) -> term().
get(Key , Default) ->
    %% NOTE : get/2 was initially wrongly success typed with {ok, term()}
    %% but it will obviously always return the retrieved value or the default
    %% hence it never fails, even if the process does not exist.
    %% The typing is simply any term
    application:get_env(verontas , Key , Default).

%% @equiv application:set_env(verontas, Par, Val)
-spec set(atom() , term()) -> ok.
set(Par , Val) ->
    application:set_env(verontas , Par , Val).
