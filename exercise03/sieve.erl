-module(sieve).
-export([takePrims/1]).

ints() -> ints_from(2).

ints_from(N) ->
    fun() ->
        [N | ints_from(N + 1)]
    end.

take(N, Lazy) ->
    if
        N == 0 -> [];
        true -> [hd(Lazy()) | take(N - 1, tl(Lazy()))]
    end.

filter(Pred, Lazy) ->
fun() ->
  [X|L] = Lazy(),
  FOO = Pred(X),
  if
    FOO -> [X | filter(Pred, L)];
    true -> (filter(Pred, L))()
  end
end.

sieve(Lazy) ->
  fun() ->
    [H|T] = Lazy(),
    [H | sieve(filter(fun(X) -> X rem H /= 0 end, T))]
  end.

takePrims(N) ->
  take(N, sieve(ints())).

% $ sieve:takePrims(9). => [2,3,5,7,11,13,17,19,23]
