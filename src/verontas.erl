% @doc verontas public API.
% @end
-module(verontas).

-behavior(application).

% Callbacks
-export([start/2]).
-export([stop/1]).

%--- Callbacks -----------------------------------------------------------------

start(_Type, _Args) -> verontas_sup:start_link().

stop(_State) -> ok.
