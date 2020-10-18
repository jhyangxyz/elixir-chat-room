defmodule ElixirEncryptedChatWeb.PageController do
  use ElixirEncryptedChatWeb, :controller

  alias ElixirEncryptedChat.ChatRoom

  def index(conn, _params) do
    messages = ChatRoom.list_last_messages()
    render(conn, "index.html", messages: messages)
  end
end
