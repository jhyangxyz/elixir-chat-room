# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_encrypted_chat,
  ecto_repos: [ElixirEncryptedChat.Repo]

# Configures the endpoint
config :elixir_encrypted_chat, ElixirEncryptedChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eARf/wrcmp3RsPELqHkimjNRWcWGO2THH9rUbeR6OYQLdO7agDJR70FUI4ehXvhA",
  render_errors: [view: ElixirEncryptedChatWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirEncryptedChat.PubSub,
  live_view: [signing_salt: "QFs4sDdH"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
