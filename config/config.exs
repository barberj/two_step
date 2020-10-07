# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :two_step,
  ecto_repos: [TwoStep.Repo]


config :two_step, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [router: TwoStepWeb.Router],
    "priv/static/alternate_swagger.json" => [router: TwoStepWeb.AlternateRouter]
  }

# Configures the endpoint
config :two_step, TwoStepWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XACU14X6vAhhwGqa/MrrkrQ6qrB08R6aK/KiDvpZjC28FUZ73zy+4kSngmPZTACl",
  render_errors: [view: TwoStepWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TwoStep.PubSub,
  live_view: [signing_salt: "LjTwXF4+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
config :phoenix_swagger, json_library: Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
