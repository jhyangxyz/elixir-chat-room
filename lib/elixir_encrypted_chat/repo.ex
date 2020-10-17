defmodule ElixirEncryptedChat.Repo do
  use Ecto.Repo,
    otp_app: :elixir_encrypted_chat,
    adapter: Ecto.Adapters.Postgres
end
