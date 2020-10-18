defmodule ElixirEncryptedChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ElixirEncryptedChat.Repo,
      # Start the Telemetry supervisor
      ElixirEncryptedChatWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ElixirEncryptedChat.PubSub},
      # Start Presence tracker
      ElixirEncryptedChatWeb.Presence,
      # Start the Endpoint (http/https)
      ElixirEncryptedChatWeb.Endpoint
      # Start a worker by calling: ElixirEncryptedChat.Worker.start_link(arg)
      # {ElixirEncryptedChat.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirEncryptedChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirEncryptedChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
