-module(scalarProduct).
-export([scalarProduct/2]).

element([]) -> 0;
element([{X,Y}|L]) -> (X * Y) + element(L).

scalarProduct([],[]) -> 0;
scalarProduct(L1,L2) -> element(lists:zip(L1, L2)).

%% $ scalarProduct:scalarProduct([3,1,2],[4,1,7]). => 27
