%%%-------------------------------------------------------------------
%%% @author Igor Kopestenski
%%% 2019, <UCLouvain>
%%% @doc
%%%
%%% @end
%%% Created : 12. Sep 2019 17:04
%%%-------------------------------------------------------------------
-module(verontas_util).

%% API
-export([]).

%%--------------------------------------------------------------------
%% @private
find_beam(Module) when is_atom(Module) ->
  code:where_is_file(Module ++ ".beam").