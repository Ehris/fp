-module(fibgen).
-export([fib/1]).

nth(N, Lazy) ->
  if
    N == 0 -> hd(Lazy());
    true -> nth(N - 1, tl(Lazy()))
  end.

fibgen(A, B) ->
  fun() ->
    [A | fibgen(B, A + B)]
  end.

fib(N) ->
  nth(N, fibgen(0, 1)).
