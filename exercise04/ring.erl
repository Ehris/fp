-module(ring).
-export([go_ring/3, node/3]).

runner(Child, 0) ->
  timer:sleep(500),
  receive
    {quit, _} ->
      Child ! {quit, self()},
      io:format("~w: quit~n", [self()])
  end;
runner(Child, M) ->
  timer:sleep(500),
  receive
    {Msg, _} ->
      io:format("~w: ~s~n", [M, Msg]),
      Child ! {Msg, self()}
  end,
  runner(Child, M - 1).

node(0, _, _) ->
  done;
node(N, Head, M) ->
  NullPid = c:pid(0, 0, 0),
  if
    Head == NullPid ->
      H = self();
    true ->
      H = Head
  end,
  Child = spawn(ring, node, [N - 1, H, M]),
  if
    N - 1 == 0 ->
      runner(H, M);
    true ->
      runner(Child, M)
  end.

send_msgs(0, Ring, _) ->
  timer:sleep(2000),
  Ring ! {quit, self()};
send_msgs(M, Ring, Msg) ->
  Ring ! {Msg, self()},
  send_msgs(M - 1, Ring, Msg).

go_ring(N, M, Msg) ->
  Ring = spawn(ring, node, [N, c:pid(0, 0, 0), M]),
  timer:sleep(1000),
  send_msgs(M, Ring, Msg),
  timer:sleep(5000),
  done.

% Eshell V5.10.1  (abort with ^G)
% 1> ring:go_ring(10, 5, "foo").
% 5: foo
% 5: foo
% 5: foo
% 5: foo
% 5: foo
% 5: foo
% 5: foo
% 5: foo
% 5: foo
% 5: foo
% 4: foo
% 4: foo
% 4: foo
% 4: foo
% 4: foo
% 4: foo
% 4: foo
% 4: foo
% 4: foo
% 4: foo
% 3: foo
% 3: foo
% 3: foo
% 3: foo
% 3: foo
% 3: foo
% 3: foo
% 3: foo
% 3: foo
% 3: foo
% 2: foo
% 2: foo
% 2: foo
% 2: foo
% 2: foo
% 2: foo
% 2: foo
% 2: foo
% 2: foo
% 2: foo
% 1: foo
% 1: foo
% 1: foo
% 1: foo
% 1: foo
% 1: foo
% 1: foo
% 1: foo
% 1: foo
% 1: foo
% <0.34.0>: quit
% <0.35.0>: quit
% <0.36.0>: quit
% <0.37.0>: quit
% <0.38.0>: quit
% <0.39.0>: quit
% <0.40.0>: quit
% <0.41.0>: quit
% <0.42.0>: quit
% <0.43.0>: quit
% done
