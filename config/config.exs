# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

gen_salt = fn length ->
  :crypto.strong_rand_bytes(length) |> Base.encode64() |> binary_part(0, length)
end

# Configures the endpoint
config :steef_min, SteefMinWeb.Endpoint,
  adapter: Bandit.PhoenixAdapter,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: SteefMinWeb.ErrorHTML, json: SteefMinWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: SteefMin.PubSub,
  live_view: [signing_salt: System.get_env("PHX_LIVE_VIEW_SALT") || gen_salt.(8)]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.25.4",
  steef_min: [
    args:
      ~w(js/app.js --bundle --target=es2022 --outdir=../priv/static/assets/js --external:/fonts/* --external:/images/* --alias:@=.),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => [Path.expand("../deps", __DIR__), Mix.Project.build_path()]}
  ]

config :tailwind,
  version: "4.1.7",
  steef_min: [
    args: ~w(
      --input=assets/css/app.css
      --output=priv/static/assets/css/app.css
    ),
    cd: Path.expand("..", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase
