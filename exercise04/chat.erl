-module(chat).
-export([mainloop/1, server/0, client/2, get_clients/0, send_msg/2, recv_msg/0]).

mainloop(Clients) ->
  receive
    {login, Name} ->
      mainloop(lists:append(Clients, [Name]));
    {getClients, Client} ->
      Client ! {Clients, self()},
      mainloop(Clients);
    {Sender, Receiver, Message} ->
      global:send(Receiver, {Sender, Receiver, Message}),
      mainloop(Clients)
  end.

server() ->
  net_kernel:start([server, shortnames]),
  Server = spawn(chat, mainloop, [[]]),
  global:register_name(chatserver, Server).

client(Name, Node) ->
  global:register_name(Name, self()),
  net_kernel:start([Name, shortnames]),
  net_kernel:connect_node(Node),
  timer:sleep(500),
  global:send(chatserver, {login, Name}).

get_clients() ->
  Pid = global:send(chatserver, {getClients, self()}),
  receive
    {Clients, Pid} ->
      Clients
  end.

send_msg(Client, Message) ->
  [Self] = lists:filter(fun(X) -> global:whereis_name(X) == self() end, chat:get_clients()),
  global:send(chatserver, {Self, Client, Message}).

recv_msg() ->
  [Self] = lists:filter(fun(X) -> global:whereis_name(X) == self() end, chat:get_clients()),
  receive
    {Sender, Self, Message} ->
      io:format("~w: ~s~n", [Sender, Message])
  end.

% Beispiel ist in Textform schwierig, ich würde es aber in der Übung demonstrieren.
