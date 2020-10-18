defmodule ElixirEncryptedChat.ChatRoomTest do
  use ElixirEncryptedChat.DataCase

  alias ElixirEncryptedChat.ChatRoom

  describe "messages" do
    alias ElixirEncryptedChat.ChatRoom.Message

    @valid_attrs %{body: "some body", name: "some name"}
    @update_attrs %{body: "some updated body", name: "some updated name"}
    @invalid_attrs %{body: nil, name: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ChatRoom.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert ChatRoom.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert ChatRoom.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = ChatRoom.create_message(@valid_attrs)
      assert message.body == "some body"
      assert message.name == "some name"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ChatRoom.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, %Message{} = message} = ChatRoom.update_message(message, @update_attrs)
      assert message.body == "some updated body"
      assert message.name == "some updated name"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = ChatRoom.update_message(message, @invalid_attrs)
      assert message == ChatRoom.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = ChatRoom.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> ChatRoom.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = ChatRoom.change_message(message)
    end
  end

  describe "users" do
    alias ElixirEncryptedChat.ChatRoom.User

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ChatRoom.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert ChatRoom.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert ChatRoom.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = ChatRoom.create_user(@valid_attrs)
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ChatRoom.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = ChatRoom.update_user(user, @update_attrs)
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = ChatRoom.update_user(user, @invalid_attrs)
      assert user == ChatRoom.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = ChatRoom.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> ChatRoom.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = ChatRoom.change_user(user)
    end
  end
end
