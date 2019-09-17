% % @doc myapp public API.
% % @end
-module(myapp).
-include_lib("kernel/include/inet.hrl").
% -export([init_nif/0]).
-export([foo/1]).
-export([bar/1]).
-export([foobar/1]).
% -export([loop/0]).
% -export([init_ygg_nif/0]).
-export([get_soname/0]).
-export([get_ip/0]).
-export([set_ip/0]).
-export([init_ygg_messaging/1]).

% -on_load(init_ygg_nif/0).
-on_load(get_soname/0).
-on_load(get_ip/0).
-on_load(set_ip/0).
-on_load(init_ygg_messaging/1).
%
% add_host(IP, NAME) ->
%   logger:info("Adding host ~s@~s ~n", [IP, NAME]),
%   case inet:parse_address(IP) of
%     {ok, {X,Y,Z,W}} ->
%       inet_db:add_host({X,Y,Z,W}, [NAME]);
%     {error, einval} ->
%       logger:error("Error parsing ip: ~s ~n ", [IP])
%   end.
%
% loop() ->
%   receive
%     {msg, String} ->
%       logger:info("~s~n", [String]);
%     {notify, String} ->
%       logger:info("~s~n", [String]);
%     {notify, IP, NAME} ->
%       add_host(IP, NAME);
%     true ->
%       logger:info("Received something~n")
%     end,
%   loop().


%
% print_ip() ->
%   logger:info("My ip is ~s ~n", [get_ip()]).

%
% init_nif() ->
%   SoName = get_soname(),
%
%     Pid=spawn(?MODULE, loop, []),
%     foobar(Pid),
%     ok = erlang:load_nif(SoName, 0),
%     foobar(Pid),
%     ok.
%
%

%

%
%%%-------------------------------------------------------------------
%%% Shell warnings partial output after call to "make clean install"
%%% in libyggdrasil.
%%%-------------------------------------------------------------------
% In file included from src/protocols/../data_structures/specialized/neighbour_list.h:15:0,
%                  from src/protocols/discovery.h:6,
%                  from src/api.c:4:
% src/protocols/../data_structures/specialized/../generic/list.h:31:1: warning: function declaration isn't a prototype [-Wstrict-prototypes]
%  list* list_init();
%  ^~~~
% src/api.c: In function 'init_yggdrasil':
% src/api.c:12:23: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
%    ntconf.wifi_channel = wifi_channel;
%                        ^
% src/api.c:13:15: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
%    ntconf.name = ssid;
%                ^
% src/api.c:14:17: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
%    ntconf.filter = YGG_filter;
%                  ^
% src/api.c:10:11: warning: unused variable 'ch' [-Wunused-variable]
%    Channel ch;
%            ^~
% src/api.c: At top level:
% src/api.c:37:6: warning: function declaration isn't a prototype [-Wstrict-prototypes]
%  void start_yggdrasil() {
%       ^~~~~~~~~~~~~~~
% src/api.c:58:11: warning: function declaration isn't a prototype [-Wstrict-prototypes]
%  msg_type* deliver_msg() {
%            ^~~~~~~~~~~
% src/api.c:86:13: warning: function declaration isn't a prototype [-Wstrict-prototypes]
%  const char* get_ip() {
%%%-------------------------------------------------------------------

-behaviour(gen_server).

%% API
-export([start_link/0]).

%% gen_server callbacks
-export([init/1 ,
         handle_call/3 ,
         handle_cast/2 ,
         handle_info/2 ,
         terminate/2 ,
         code_change/3]).

%%====================================================================
%% Macros
%%====================================================================

-define(SERVER , ?MODULE).

%%====================================================================
%% Records
%%====================================================================

-record(state , {
    addrs :: [{inet:ip4_address(), term()}] | []
}).

-type state() :: #state{}.

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
    {ok , State :: state()}
    | {ok , State :: state() , timeout()
    | hibernate}
    | {stop , Reason :: term()} | ignore).
init([]) ->
    logger:log(notice, "Initializing task worker module"),

    schedule_yggdrasil_init(5000),
    {ok , #state{
        addrs = []
    }}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling call messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_call(Request :: term() , From :: {pid() , Tag :: term()} ,
                  State :: state()) ->
                     {reply , Reply :: term() , NewState :: state()} |
                     {reply , Reply :: term() , NewState :: state() , timeout() | hibernate} |
                     {noreply , NewState :: state()} |
                     {noreply , NewState :: state() , timeout() | hibernate} |
                     {stop , Reason :: term() , Reply :: term() , NewState :: state()} |
                     {stop , Reason :: term() , NewState :: state()}).
handle_call(_Request , _From , State) ->
    {reply , ok , State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling cast messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_cast(Request :: term() , State :: state()) ->
    {noreply , NewState :: state()} |
    {noreply , NewState :: state() , timeout() | hibernate} |
    {stop , Reason :: term() , NewState :: state()}).
% handle_cast({start_task, TaskName} , State) ->
%     %% TODO : basic approach for generic task execution can be done using :
%     %% List = achlys:get_all_tasks(),
%     %% T = hd([ X || X <- List, #{name := N} = X, N =:= TaskName ]),
%     %% #{function := Fun, targets := _Targets} = T,
%     %% % TODO : Check if part of destination set
%     %% Result = Fun(),
%     {noreply , State};

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
-spec(handle_info(Info :: timeout() | term() , State :: state()) ->
    {noreply , NewState :: state()} |
    {noreply , NewState :: state() , timeout() | hibernate} |
    {stop , Reason :: term() , NewState :: state()}).
handle_info(<<1>> , State) ->
    init_ygg_messaging(self()),
    {noreply , State, hibernate};
%%--------------------------------------------------------------------
handle_info({notify, Ip, Name} , State) ->
    logger:notice("Adding host ~s@~s ~n", [Ip, Name]),
    case inet:parse_address(Ip) of
      {ok, {X,Y,Z,W}} ->
        inet_db:add_host({X,Y,Z,W}, [lists:flatten(string:replace(Ip, ".", "-", all))]),
        {noreply , State#state{
          addrs = [{{X,Y,Z,W}, lists:flatten(string:replace(Ip, ".", "-", all))}] ++ State#state.addrs}
        , hibernate};
      {error, einval} ->
        logger:error("Error parsing ip: ~s ~n ", [Ip]),
        {noreply, State, hibernate};
      _ ->
        logger:error("Unknown Error parsing ip: ~s ~n ", [Ip]),
        {noreply, State, hibernate}
    end;
%%--------------------------------------------------------------------
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
                State :: state()) -> term()).
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
-spec(code_change(OldVsn :: term() | {down , term()} , State :: state() ,
                  Extra :: term()) ->
                     {ok , NewState :: state()} | {error , Reason :: term()}).
code_change(_OldVsn , State , _Extra) ->
    {ok , State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @private

schedule_yggdrasil_init(Interval) ->
    erlang:send_after(Interval, ?SERVER, <<1>>).


%%--------------------------------------------------------------------
%% @private
% init_ygg_nif() ->
%   SoName = get_soname(),
%   ok = erlang:load_nif(SoName, 0),
%   init_ygg().

%%--------------------------------------------------------------------
%% @private
get_soname() ->
  SoName = filename:join(
    case code:priv_dir(?MODULE) of
        {error, bad_name} ->
          %% this is here for testing purposes
          filename:join(
            [filename:dirname(code:which(?MODULE)),"..","priv"]);
        Dir ->
          Dir
      % end, "myapp").
  end, "myapp"),
  try erlang:load_nif(SoName, 0) of
    ok ->
      init_ygg()
  catch
    _:_ ->
      logger:error("Failed to load NIF")
  end.

%%--------------------------------------------------------------------
%% @private
init_ygg() ->
  logger:info("Yggdrasil not Loaded~n").

%%--------------------------------------------------------------------
%% @private
get_ip() ->
  unknown.

set_ip() ->
  Ip = myapp:get_ip(),
  case inet:parse_address(Ip) of
    {ok, {X,Y,Z,W}} ->
      partisan_config:set(listen_addrs, [#{ip => {X,Y,Z,W}, port => partisan_config:get(peer_port)}]),
      inet_db:add_host({X,Y,Z,W}, [lists:flatten(string:replace(Ip, ".", "-", all))]);
    {error, einval} ->
      logger:error("Error parsing ip: ~s ~n ", [Ip]);
    _ ->
      logger:error("Unknown Error parsing ip: ~s ~n ", [Ip])
  end.

%%--------------------------------------------------------------------
%% @private
init_ygg_messaging(Pid) ->
  logger:notice("Yggdrasil not Loaded Pid : ~p ~n", [Pid]).

foo(_X) ->
    logger:info("foo~n").
bar(_Y) ->
    logger:info("bar~n").

  foobar(Pid) ->
    logger:info("~w~n", [Pid]).
