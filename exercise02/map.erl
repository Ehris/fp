-module(map).
-export([ints/0, take/2, map/2, takeDoubledInts/1]).

ints() -> ints_from(0).

ints_from(N) ->
    fun() ->
        [N | ints_from(N + 1)]
    end.

take(N, Lazy) ->
    if
        N == 0 -> [];
        true -> [hd(Lazy()) | take(N - 1, tl(Lazy()))]
    end.

map(F, Lazy) ->
  fun() ->
    [F(hd(Lazy())) | map(F, tl(Lazy()))]
  end.

takeDoubledInts(N) ->
  take(N, map(fun(X) -> 2 * X end, ints())).

%% $ map:take(5, map:ints()). => [0,1,2,3,4]
%% $ map:takeDoubledInts(5). => [0,2,4,6,8]
