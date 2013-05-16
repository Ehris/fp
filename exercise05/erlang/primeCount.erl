-module(primeCount).
-compile(export_all).

sieve([]) -> [];
sieve(List) ->
  H = hd(List),
  [H | sieve(lists:filter(fun(X) -> X rem H /= 0 end, tl(List)))].

primes(Maximum) ->
  sieve(lists:seq(2, Maximum)).

counter(From, To, Segment, Pid) ->
  if
    From + Segment >= To ->
      Len = length(lists:filter(fun(X) -> X >= From + 1 end, primes(To))),
      Pid ! {Len, self()};
    true ->
      Len = length(lists:filter(fun(X) -> X >= From + 1 end, primes(From + Segment))),
      Pid ! {Len, self()},
      spawn(primeCount, counter, [From + Segment, To, Segment, Pid])
  end.

receiveResults(N) ->
  X = round(N),
  Y = N - X,
  if
    X == 0 ->
      if
        Y > 0.0 ->
          receive
            {Value, _} ->
              Value
          end;
        true ->
          0.0
      end;
    true ->
      receive
        {Value, _} ->
          Value + receiveResults(N - 1)
      end
  end.

count(From, To, Segment) ->
  spawn(primeCount, counter, [From, To, Segment, self()]),
  round(receiveResults((To - From) / Segment)).

% Je kleiner ich das Segment mache, um so länger läuft der Algorithmus.
%
% Eshell V5.9.3.1  (abort with ^G)
% 1> primeCount:count(0, 40000, 40000).
% 4203
% 2> primeCount:count(0, 40000, 20000).
% 4203
% 3> primeCount:count(0, 40000, 10000).
% 4203
% 4> primeCount:count(0, 40000, 5000).
% 4203
% 5> primeCount:count(0, 40000, 4000).
% 4203
% 6> primeCount:count(0, 40000, 2000).
% 4203
% 7> primeCount:count(0, 40000, 1000).
% 4203
% 8> primeCount:count(0, 40000, 500).
% 4203
% 9> primeCount:count(0, 40000, 400).
% 4203
