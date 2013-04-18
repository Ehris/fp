-module(removeOdd).
-export([removeOdd/1]).

removeOdd([]) -> [];
removeOdd(L) -> [X || X <- L, X rem 2 == 0].

%% $ removeOdd:removeOdd([1,2,3,4,5,6]). => [2,4,6]
