-module(branch).
-export([go/1, loop/2]).

go(Lim) ->
  Root = spawn(branch, loop, [1, Lim]),
  Root ! {createdBy, self()},
  io:format("process ~w created at toplevel.~n", [Root]).

loop(Lim, Lim) ->
  receive
    {createdBy, Parentpid} ->
      Parentpid ! {confirmed, self()}
  end;
loop(Count, Lim) when Count =< Lim ->
  Count1 = Count + 1,
  Child1 = spawn(branch, loop, [Count1, Lim]),
  Child2 = spawn(branch, loop, [Count1, Lim]),
  Child1 ! {createdBy, self()},
  Child2 ! {createdBy, self()},
  receive
    {createdBy, Parentpid} ->
      io:format("process ~w created by ~w at count ~w.~n", [self(), Parentpid, Count]),
      Parentpid ! {confirmed, self()}
  end,
  receive
    {confirmed, Childpid1} ->
      io:format("process ~w confirmed creation to ~w at count ~w.~n", [Childpid1, self(), Count])
  end,
  receive
    {confirmed, Childpid2} ->
      io:format("process ~w confirmed creation to ~w at count ~w.~n", [Childpid2, self(), Count])
  end.

% Eshell V5.10.1  (abort with ^G)
% 1> branch:go(3).
% process <0.34.0> created at toplevel.
% process <0.34.0> created by <0.32.0> at count 1.
% process <0.35.0> created by <0.34.0> at count 2.
% process <0.36.0> created by <0.34.0> at count 2.
% process <0.37.0> confirmed creation to <0.35.0> at count 2.
% process <0.39.0> confirmed creation to <0.36.0> at count 2.
% process <0.35.0> confirmed creation to <0.34.0> at count 1.
% process <0.38.0> confirmed creation to <0.35.0> at count 2.
% process <0.40.0> confirmed creation to <0.36.0> at count 2.
% process <0.36.0> confirmed creation to <0.34.0> at count 1.
% ok
