-module(erlang_evdev_driver).

-behavior(application).
-export([start/2,stop/1]).

-behavior(supervisor).
-export([init/1]).

%%====================================================================
%% API functions
%%====================================================================
start(_, _) ->
    supervisor:start_link(?MODULE, []).


stop(_) ->
    erl_ddll:unload("erlang_evdev_driver"),
    ok.


init([]) ->
    erl_ddll:start(),
    PrivDir = code:priv_dir(erlang_evdev_driver),
    ok = erl_ddll:load_driver(PrivDir, "erlang_evdev_driver"),
    % Cmd = io_lib:format("erlang_evdev_driver ~s", ["/dev/input/event3"]),
    % Port = open_port({spawn_driver, Cmd}, [binary,stream]),
    % io:format("open_port ~p", [Port]),
    {ok, {{rest_for_one, 0, 1}, []}}.

%%====================================================================
%% Internal functions
%%====================================================================
