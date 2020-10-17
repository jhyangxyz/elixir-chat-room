defmodule ElixirEncryptedChatWeb.PageController do
  use ElixirEncryptedChatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
