-module(database).
-export([server/1, start/0, set/3, get/2]).

server(Storage) ->
  receive
    {set, Key, Value, _} ->
      IsValidKey = dict:is_key(Key, Storage),
      if
        IsValidKey == true ->
          server(dict:update(Key, fun(_) -> Value end, Storage));
        true ->
          server(dict:store(Key, Value, Storage))
      end;
    {get, Key, Client} ->
      IsValidKey = dict:is_key(Key, Storage),
      if
        IsValidKey == true ->
          Client ! {dict:fetch(Key, Storage), self()},
          server(Storage);
        true ->
          Client ! {error, self()},
          server(Storage)
      end
  end.
  
start() ->
  spawn(database, server, [dict:new()]).

set(Server, Key, Value) ->
  Server ! {set, Key, Value, self()}.

get(Server, Key) ->
  Server ! {get, Key, self()},
  receive
    {Value, Server} ->
      Value
  end.

% Eshell V5.10.1  (abort with ^G)
% 1> Db = database:start().
% <0.34.0>
% 2> database:set(Db, foo, "bar").
% {set,foo,"bar",<0.32.0>}
% 3> database.get(Db, foo).
% * 1: syntax error before: '.'
% 3> database.get(Db, "foo").
% * 1: syntax error before: '.'
% 3> database:get(Db, foo).
% "bar"
% 4> database:get(Db, fo).
% error
% 5> database:get(Db, foo).
% "bar"
% 6> database:set(Db, fnord, 42).
% {set,fnord,42,<0.32.0>}
% 7> database:get(Db, fnord).
% 42
% 8> database:get(Db, fnor).
% error
% 9> database:set(Db, fnord, 23).
% {set,fnord,23,<0.32.0>}
% 10> database:get(Db, fnord).
% 23

% Eine Möglichkeit wäre die Keys zu normalisieren, oder genau zu dokumentieren.
