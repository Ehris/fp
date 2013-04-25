-module(curry).
-export([curry3/1, replace/3, replaceLL/3]).

curry3(Foo3) ->
  fun(X) ->
    (fun(Y) ->
      (fun(Z) ->
        Foo3(X, Y, Z)
      end)
    end)
  end.

replace(Elem, ElemNeu, Liste) ->
  [(fun(A, E, EN) -> (if A == E -> EN; true -> A end) end)(X, Elem, ElemNeu) || X <- Liste].

replaceLL(Elem, ElemNeu, ListenListe) ->
  lists:map(((curry3(fun curry:replace/3))(Elem))(ElemNeu), ListenListe).
