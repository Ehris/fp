-module(remdup).
-export([remdup/1]).

remdup([]) -> [];
remdup([H|T]) -> lists:append([H], [X || X <- remdup(T), X /= H]).

%% Ja, es gibt noch weiter möglichkeiten, z.B. remdup(L) -> lists:usort(L).
