%%%-------------------------------------------------------------------
%%% @author Igor Kopestenski
%%% 2019, <UCLouvain>
%%% @doc
%%%
%%% @end
%%% Created : 12. Sep 2019 17:06
%%%-------------------------------------------------------------------

%%====================================================================
%% Time Intervals (ms)
%%====================================================================

-define(MS , 20).
-define(ONE , 1000).
-define(THREE , 3000).
-define(FIVE , 5000).
-define(TEN , 10000).
-define(HMIN , 30000).
-define(MIN , 60000).
-define(TWOMIN , 120000).
-define(THREEMIN , 180000).

-define(MILLION , 1000000).

%%====================================================================
%% Common Macros
%%====================================================================

%% Thanks to https://github.com/erszcz
%% Helper macro for declaring children of supervisor
% -define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).
-define(SUPFLAGS(Strategy, Intensity , Period) , #{strategy  => Strategy
    ,                                    intensity => Intensity
    ,                                    period    => Period
}).

-define(VERONTAS_TOPOLOGY_SUP , #{id     => verontas_topology_sup
    , start    => {verontas_topology_sup , start_link , []}
    , restart  => permanent
    , shutdown => 5000
    , type     => supervisor
    , modules  => [verontas_topology_sup]
}).

-define(VERONTAS_TOPOLOGY_SERVER , #{id     => verontas_topology_server
    , start    => {verontas_topology_server , start_link , []}
    , restart  => permanent
    , shutdown => 5000
    , type     => worker
    , modules  => [verontas_topology_server]
}).

-define(VERONTAS_TOPOLOGY_MACHINE , #{id     => verontas_topology_machine
    , start    => {verontas_topology_machine , start_link , []}
    , restart  => permanent
    , shutdown => 5000
    , type     => worker
    , modules  => [verontas_topology_machine]
}).