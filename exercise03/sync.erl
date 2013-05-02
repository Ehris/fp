-module(sync).
-export([start/4]).

start(F1, A1, F2, A2) ->
  P = self(),
  spawn(fun() -> calculator(P, F1, A1) end),
  spawn(fun() -> calculator(P, F2, A2) end),
  receive
    {RET1, _} ->
      receive
        {RET2, _} ->
          RET1 * RET2
      end
  end.

calculator(P, F, A) ->
  RET = apply(F, A),
  P ! {RET, self()}.

% Eshell V5.10.1  (abort with ^G)
% 1> sync:start(fun(X, Y) -> X + Y end, [1, 2], fun(X, Y) -> X + Y end, [1, 2]).
% 9
