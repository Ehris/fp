-module(fib).
-export([fib/1]).

fib(0) -> 0;
fib(1) -> 1;
fib(N) -> fib(N - 1) + fib(N - 2).

%% $ fib:fib(9). => 34
%% Die Laufzeitkomplexität ist rund O(2^n).
