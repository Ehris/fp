-module(calculation).
-export([start/2]).

start(F, A) ->
  P = self(),
  spawn(fun() -> calculator(P, F, A) end),
  receive
    {RET, _} ->
      RET
  end.

calculator(P, F, A) ->
  RET = apply(F, A),
  P ! {RET, self()}.

% $ calculation:start(fun(X, Y) -> X + Y end, [1, 2]). => 3
