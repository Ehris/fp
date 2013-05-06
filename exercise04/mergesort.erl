-module(mergesort).
-export([sort/2, mergesort/1]).

sort(List, Parent) ->
  if
    length(List) == 1 ->
      Parent ! {List, self()};
    true ->
      {List1, List2} = lists:split(trunc(length(List) / 2), List),
      Part1 = spawn(mergesort, sort, [List1, self()]),
      Part2 = spawn(mergesort, sort, [List2, self()]),
      receive
        {Result1, Part1} ->
          receive
            {Result2, Part2} ->
              Parent ! {lists:merge(Result1, Result2), self()}
          end
      end
  end.

mergesort([]) ->
  [];
mergesort(List) ->
  Sort = spawn(mergesort, sort, [List, self()]),
  receive
    {Result, Sort} ->
      Result
  end.

% Eshell V5.10.1  (abort with ^G)
% 1> mergesort:mergesort([3,4,8,1,5,7,3,4,2,1,7]).
% [1,1,2,3,3,4,4,5,7,7,8]
