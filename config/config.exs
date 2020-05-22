# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :oban_tutorial,
  ecto_repos: [ObanTutorial.Repo]

# Configures the endpoint
config :oban_tutorial, ObanTutorialWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "si3/Tc2NCsKJdIMLro1OxWutlIi3Ua8073Ul4xNrDwI0/BgmozCu943zaKn1GHBS",
  render_errors: [view: ObanTutorialWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ObanTutorial.PubSub,
  live_view: [signing_salt: "pE/5wnDs"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :oban_tutorial, Oban,
  repo: ObanTutorial.Repo,
  queues: [default: 10]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
