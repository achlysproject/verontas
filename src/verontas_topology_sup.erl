%%%-------------------------------------------------------------------
%%% @author Igor Kopestenski
%%% 2019, <UCLouvain>
%%% @doc
%%%
%%% @end
%%% Created : 12. Sep 2019 19:01
%%%-------------------------------------------------------------------
-module(verontas_topology_sup).

-include("verontas.hrl").

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER , ?MODULE).

%%%===================================================================
%%% API functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the supervisor
%%
%% @end
%%--------------------------------------------------------------------
-spec(start_link() ->
    {ok , Pid :: pid()} | ignore | {error , Reason :: term()}).
start_link() ->
    supervisor:start_link({local , ?SERVER} , ?MODULE , []).

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Whenever a supervisor is started using supervisor:start_link/[2,3],
%% this function is called by the new process to find out about
%% restart strategy, maximum restart frequency and child
%% specifications.
%%
%% The child specifications parameters are :
%% 
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
%%     child_id() = term()
%%     mfargs() = {M :: module(), F :: atom(), A :: [term()]}
%%     modules() = [module()] | dynamic
%%     restart() = permanent | transient | temporary
%%     shutdown() = brutal_kill | timeout()
%%     worker() = worker | supervisor
%% @end
%%--------------------------------------------------------------------
-spec(init(Args :: term()) ->
    {ok , {SupFlags :: {RestartStrategy :: supervisor:strategy() ,
                        MaxR :: non_neg_integer() , MaxT :: non_neg_integer()} ,
           [ChildSpec :: supervisor:child_spec()]
    }} |
    ignore |
    {error , Reason :: term()}).
init([]) ->
    {ok , {?SUPFLAGS(rest_for_one, ?THREE, ?TEN) , [
            ?VERONTAS_TOPOLOGY_SERVER
            , ?VERONTAS_TOPOLOGY_MACHINE
        ]}}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
