defmodule ElixirChatWeb.PageController do
  use ElixirChatWeb, :controller

  alias ElixirChat.ChatRoom

  def index(conn, _params) do
    messages = ChatRoom.list_last_messages()
    render(conn, "index.html", messages: messages)
  end
end
