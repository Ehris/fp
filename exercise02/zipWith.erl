-module(zipWith).
-export([fibs/1, zipWith/3]).

fibgen(A, B) ->
  fun() ->
    [A | fibgen(B, A + B)]
  end.

take(N, Lazy) ->
    if
        N == 0 -> [];
        true -> [hd(Lazy()) | take(N - 1, tl(Lazy()))]
    end.

zipWith(F, Lazy1, Lazy2) ->
  fun() ->
    [F(hd(Lazy1()), hd(Lazy2())) | zipWith(F, tl(Lazy1()), tl(Lazy2()))]
  end.

fibs(N) ->
  take(N, fun() -> [0 | fun() -> [1 | zipWith(fun(X, Y) -> X + Y end, fibgen(0, 1), fibgen(1, 1))] end] end).

%% $ zipWith:fibs(10). => [0,1,1,2,3,5,8,13,21,34]
