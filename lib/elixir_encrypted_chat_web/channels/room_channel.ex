defmodule ElixirEncryptedChatWeb.RoomChannel do

  use Phoenix.Channel

  alias ElixirEncryptedChat.ChatRoom
  alias ElixirEncryptedChatWeb.Presence

  use ElixirEncryptedChatWeb, :channel

  def join("chat_room:lobby", _payload, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_in("message:new", payload, socket) do
    spawn(fn -> save_message(payload) end)
    broadcast socket, "message:new", payload
    {:noreply, socket}
  end

  defp save_message(message) do
    ChatRoom.create_message(message)
  end

  def handle_info(:after_join, socket) do
    {:ok, _} = Presence.track(socket, socket.assigns.user, %{
      online_at: inspect(System.system_time(:second))
    })
    push(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
  end
end
