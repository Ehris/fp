-module(bank).
-export([go_bank/1, customer/1, account/1]).

customer(Account) ->
  timer:sleep(random:uniform(500)),
  Account ! {random:uniform(10), self()},
  receive
    {success, _} ->
      customer(Account);
    {failure, _} ->
      customer(Account);
    {empty, _} ->
      io:format("~w: No money to draw!~n", [self()])
  end.

account(0) ->
  receive
    {_, Customer} ->
      io:format("~w: empty~n", [Customer]),
      Customer ! {empty, self()},
      account(0)
  end;
account(Balance) ->
  receive
    {Value, Customer} ->
      if
        Balance - Value >= 0 ->
          io:format("~w: draw ~w~n", [Customer, Value]),
          Customer ! {success, self()},
          account(Balance - Value);
        true ->
          io:format("~w: failure~n", [Customer]),
          Customer ! {failure, self()},
          account(Balance)
      end
  end.

go_bank(Balance) ->
  Account = spawn(bank, account, [Balance]),
  spawn(bank, customer, [Account]),
  spawn(bank, customer, [Account]),
  done.

% Eshell V5.10.1  (abort with ^G)
% 1> bank:go_bank(100).
% done
% <0.36.0>: draw 8
% <0.35.0>: draw 8
% <0.35.0>: draw 6
% <0.36.0>: draw 6
% <0.36.0>: draw 6
% <0.35.0>: draw 6
% <0.35.0>: draw 7
% <0.36.0>: draw 7
% <0.36.0>: draw 6
% <0.35.0>: draw 6
% <0.35.0>: draw 3
% <0.36.0>: draw 3
% <0.36.0>: draw 2
% <0.35.0>: draw 2
% <0.35.0>: draw 3
% <0.36.0>: draw 3
% <0.36.0>: draw 5
% <0.35.0>: draw 5
% <0.35.0>: draw 6
% <0.36.0>: failure
% <0.36.0>: failure
% <0.35.0>: failure
% <0.35.0>: draw 1
% <0.36.0>: draw 1
% <0.36.0>: empty
% <0.35.0>: empty
% <0.36.0>: No money to draw!
% <0.35.0>: No money to draw!
