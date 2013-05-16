-module(printing).
-export([go/0, stop/0, print/1]).

process() ->
  receive
    {String, _} ->
      io:format("~s~n", [String])
  end,
  process().

go() ->
  Pid = spawn(fun() -> process() end),
  register(printer, Pid).

stop() ->
  Pid = whereis(printer),
  exit(Pid, "kill").

print(String) ->
  printer ! {String, self()}.

% Eshell V5.9.3.1  (abort with ^G)
% 1> printing:go().
% true
% 2> printing:print("foo").
% foo
% {"foo",<0.31.0>}
% 3> printing:print("bar").
% bar
% {"bar",<0.31.0>}
% 4> printing:stop().
% true
% 5> printing:print("bar").
% ** exception error: bad argument
%      in function  printing:print/1 (printing.erl, line 20)
% 6> printing:go().
% true
% 7> printing:print("bar").
% bar
% {"bar",<0.38.0>}
% 8> printing:stop().
% true
