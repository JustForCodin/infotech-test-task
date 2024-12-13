defmodule ChatManager do
  def get_or_create_room(room_name) do
    case Registry.lookup(ChatRegistry, room_name) do
      [] ->
        {:ok, _pid} = ChatRoom.start_link(room_name)
      [{pid, _}] ->
        {:ok, pid}
    end
  end

  def add_user_to_room(room_name, pid) do
    get_or_create_room(room_name)
    ChatRoom.add_user(room_name, pid)
  end

  def send_message_to_room(room_name, message) do
    get_or_create_room(room_name)
    ChatRoom.broadcast_message(room_name, message)
  end

  def remove_user_from_room(room_name, pid) do
    ChatRoom.remove_user(room_name, pid)
  end
end
