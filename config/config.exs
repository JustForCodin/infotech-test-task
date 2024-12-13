import Config

config :n2o,
  routes: [:chat],
  protocols: [:n2o_pi, :n2o_nitro, :n2o_ftp],
  host: "127.0.0.1",
  port: 8080,
  dispatch: [
    {:_, [
      {"/ws/[...]", :cowboy_websocket, N2O.Websocket},
      {"/static/[...]", :cowboy_static, {:priv_dir, :chat_app, "static"}},
      {"/[...]", :cowboy_rest, ChatRouter}
    ]}
  ]
