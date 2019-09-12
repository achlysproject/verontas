%%%-------------------------------------------------------------------
%%% @author Igor Kopestenski
%%% 2019, <UCLouvain>
%%% @doc
%%%
%%% @end
%%% Created : 12. Sep 2019 16:58
%%%-------------------------------------------------------------------
-module(verontas_app).
-author("Igor Kopestenski").

-behaviour(application).

%% Application callbacks
-export([start/2 ,
         stop/1]).

%%%===================================================================
%%% Application callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called whenever an application is started using
%% application:start/[1,2], and should start the processes of the
%% application. If the application is structured according to the OTP
%% design principles as a supervision tree, this means starting the
%% top supervisor of the tree.
%%
%% @end
%%--------------------------------------------------------------------
-spec(start(StartType :: normal | {takeover , node()} | {failover , node()} ,
            StartArgs :: term()) ->
               {ok , pid()} |
               {ok , pid() , State :: term()} |
               {error , Reason :: term()}).
start(_StartType , _StartArgs) ->
    case 'TopSupervisor':start_link() of
        {ok , Pid} ->
            {ok , Pid};
        Error ->
            Error
    end.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called whenever an application has stopped. It
%% is intended to be the opposite of Module:start/2 and should do
%% any necessary cleaning up. The return value is ignored.
%%
%% @end
%%--------------------------------------------------------------------
-spec(stop(State :: term()) -> term()).
stop(_State) ->
    ok.

%%%===================================================================
%%% Internal functions
%%%===================================================================
