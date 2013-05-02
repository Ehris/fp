-module(ham).
-export([hamming/0]).

ints() -> ints_from(1).

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

scaleStream(N, Lazy) ->
  map(fun(X) -> X * N end, Lazy).

% hamming/0 lässt sich nicht sinnvoll mit Lazy-Listen implementieren, weil wir nicht wissen,
% ob noch ein Element kommt, welches kleiner ist als ein schon bearbeitetes. z.B. für 1 -> 2,3,5
% dann würde für 2 -> 4,6,10 entstehen. Da wir aber den ersten Schritt schon abgeschlossen haben,
% können wir die 4 nicht mehr in die erste 3er Liste einmergen.

hamming() -> [].
