-module(pyTriple).
-export([pyTriple/1, ppT/1]).

pyTriple(N) ->
  [{X, Y, Z} || X <- lists:seq(2, N), Y <- lists:seq(X + 1, N), Z <- lists:seq(Y + 1, N), X * X + Y * Y == Z * Z].

ppT(N) ->
  [T || T <- pyTriple(N), (factors(element(1, T)) == []) or (factors(element(2, T)) == []) or (factors(element(3, T)) == [])].

factors(X) ->
  [Y || Y <- lists:seq(2, X - 1), (X rem Y) == 0, factors(Y) == []].

%% b) n * a * a + n * b * b = n * c * c | /n q.e.d.
