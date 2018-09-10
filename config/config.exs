# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api,
  ecto_repos: [Api.Repo]

# Configures the endpoint
config :api, ApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WnqT8Z6oDjUBs8EwtjOLnLzhfE/CWyCKNGhQ7MQWuR/Au+q8/k0VkAlDK1vJEQi1",
  render_errors: [view: ApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Api.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Guardian config
config :api, Api.Guardian,
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  issuer: "Api",
  secret_key: "E/wU4qvQ2DE27WpkUeUO2IaCPjzGoYixPY/qFqeUUtG0jSpuXs+VJGBACWBfIktu"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
