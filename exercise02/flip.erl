-module(flip).
-export([flip/1, flipc/1]).

flip(Foo2) ->
  fun(X, Y) -> Foo2(Y, X) end.

flipc(Foo2) ->
  fun(X) ->
    (fun(Y) ->
      Foo2(Y, X)
    end)
  end.

%% $ (flip:flip(fun(X, Y) -> X - Y end))(4, 1). => -3
%% $ ((flip:flipc(fun(X, Y) -> X - Y end))(4))(1). => -3
