-module(reverse).
-export([reverse/1]).

reverse([H|T]) -> lists:append(reverse(T), [H]);
reverse([]) -> [].

%% $ reverse:reverse([1,2,3,4,5,6]). => [6,5,4,3,2,1]
