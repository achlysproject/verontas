%%%-------------------------------------------------------------------
%%% @author Igor Kopestenski
%%% 2019, <UCLouvain>
%%% @doc
%%%
%%% @end
%%% Created : 12. Sep 2019 18:56
%%%-------------------------------------------------------------------
-module(verontas_topology_server).

-behaviour(gen_server).

%% API
-export([start_link/0]).

%% gen_server callbacks
-export([init/1]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([terminate/2]).
-export([code_change/3]).


% -export([get_soname/0]).
% -on_load(get_soname/0).

-define(SERVER , ?MODULE).

-record(state , {}).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the server
%%
%% @end
%%--------------------------------------------------------------------
-spec(start_link() ->
    {ok , Pid :: pid()} | ignore | {error , Reason :: term()}).
start_link() ->
    gen_server:start_link({local , ?SERVER} , ?MODULE , [] , []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Initializes the server
%%
%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason}
%% @end
%%--------------------------------------------------------------------
-spec(init(Args :: term()) ->
    {ok , State :: #state{}} | {ok , State :: #state{} , timeout() | hibernate} |
    {stop , Reason :: term()} | ignore).
init([]) ->
    {ok , #state{}}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling call messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_call(Request :: term() , From :: {pid() , Tag :: term()} ,
                  State :: #state{}) ->
                     {reply , Reply :: term() , NewState :: #state{}} |
                     {reply , Reply :: term() , NewState :: #state{} , timeout() | hibernate} |
                     {noreply , NewState :: #state{}} |
                     {noreply , NewState :: #state{} , timeout() | hibernate} |
                     {stop , Reason :: term() , Reply :: term() , NewState :: #state{}} |
                     {stop , Reason :: term() , NewState :: #state{}}).
handle_call(_Request , _From , State) ->
    {reply , ok , State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling cast messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_cast(Request :: term() , State :: #state{}) ->
    {noreply , NewState :: #state{}} |
    {noreply , NewState :: #state{} , timeout() | hibernate} |
    {stop , Reason :: term() , NewState :: #state{}}).
handle_cast(_Request , State) ->
    {noreply , State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling all non call/cast messages
%%
%% @spec handle_info(Info, State) -> {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
-spec(handle_info(Info :: timeout() | term() , State :: #state{}) ->
    {noreply , NewState :: #state{}} |
    {noreply , NewState :: #state{} , timeout() | hibernate} |
    {stop , Reason :: term() , NewState :: #state{}}).
handle_info(_Info , State) ->
    {noreply , State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
%%
%% @spec terminate(Reason, State) -> void()
%% @end
%%--------------------------------------------------------------------
-spec(terminate(Reason :: (normal | shutdown | {shutdown , term()} | term()) ,
                State :: #state{}) -> term()).
terminate(_Reason , _State) ->
    ok.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Convert process state when code is changed
%%
%% @spec code_change(OldVsn, State, Extra) -> {ok, NewState}
%% @end
%%--------------------------------------------------------------------
-spec(code_change(OldVsn :: term() | {down , term()} , State :: #state{} ,
                  Extra :: term()) ->
                     {ok , NewState :: #state{}} | {error , Reason :: term()}).
code_change(_OldVsn , State , _Extra) ->
    {ok , State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%%--------------------------------------------------------------------
% get_soname() ->
%   SoName = filename:join(
%     case code:priv_dir(?MODULE) of
%         {error, bad_name} ->
%           %% this is here for testing purposes
%           filename:join(
%             [filename:dirname(code:which(?MODULE)),"..","priv"]);
%         Dir ->
%           Dir
%       % end, "myapp").
%   end, "myapp"),
%   try erlang:load_nif(SoName, 0) of
%     ok ->
%       init_ygg()
%   catch
%     _:_ ->
%       logger:error("Failed to load NIF")
%   end.