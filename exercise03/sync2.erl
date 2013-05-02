-module(sync2).
-export([start/3]).

calculator(P, {F, A}) ->
  RET = apply(F, A),
  P ! {RET, self()}.

start(F, A, K) ->
  P = self(),
  INPUT = lists:zip(F, A),
  PIDS = lists:map(fun(I) -> spawn(fun() -> calculator(P, I) end) end, INPUT),
  RESULTS = lists:map(fun(PID) -> receive {RET, PID} -> RET end end, PIDS),
  apply(K, RESULTS).

% Eshell V5.10.1  (abort with ^G)
% 1> sync2:start([(fun(X, Y) -> X + Y end), (fun(X, Y) -> X + Y end)], [[1, 2], [1, 2]], fun(X, Y) -> X * Y end).
% 9
