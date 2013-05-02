-module(counter).
-export([start/1, stop/1, increment/1, decrement/1, show/1]).

start(N) ->
  spawn(fun() -> counter(N) end).

stop(P) ->
  P ! {stp, self()}.

increment(P) ->
  P ! {inc, self()}.

decrement(P) ->
  P ! {dec, self()}.

show(P) ->
  P ! {shw, self()},
  receive
    {RET, _} ->
      RET
  end.

counter(N) ->
  receive
    {inc, _} ->
      counter(N + 1);
    {dec, _} ->
      counter(N - 1);
    {shw, S} ->
      S ! {N, self()},
      counter(N);
    {stp, _} ->
      0
  end.
  
% Eshell V5.10.1  (abort with ^G)
% 1> P = counter:start(5).
% <0.34.0>
% 2> counter.show(P).
% * 1: syntax error before: '.'
% 2> counter:show(P).
% 5
% 3> counter:increment(P).
% {inc,<0.32.0>}
% 4> counter:show(P).
% 6
% 5> counter:decrement(P).
% {dec,<0.32.0>}
% 6> counter:show(P).
% 5
% 7> counter:stop(P).
% {stp,<0.32.0>}
