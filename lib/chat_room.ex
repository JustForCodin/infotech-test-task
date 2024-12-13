defmodule ChatRoom do
  use GenServer

  # API

  # Запуск кімнати
  def start_link(room_name) do
    GenServer.start_link(__MODULE__, %{name: room_name, users: []}, name: via_tuple(room_name))
  end

  # Додати користувача
  def add_user(room_name, pid) do
    GenServer.call(via_tuple(room_name), {:add_user, pid})
  end

  # Надіслати повідомлення
  def broadcast_message(room_name, message) do
    GenServer.cast(via_tuple(room_name), {:broadcast_message, message})
  end

  # Вихід користувача
  def remove_user(room_name, pid) do
    GenServer.call(via_tuple(room_name), {:remove_user, pid})
  end

  # Helper для іменування процесів
  defp via_tuple(name), do: {:via, Registry, {ChatRegistry, name}}

  # Callbacks

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:add_user, pid}, _from, %{users: users} = state) do
    {:reply, :ok, %{state | users: [pid | users]}}
  end

  @impl true
  def handle_call({:remove_user, pid}, _from, %{users: users} = state) do
    {:reply, :ok, %{state | users: Enum.reject(users, fn user -> user == pid end)}}
  end

  @impl true
  def handle_cast({:broadcast_message, message}, %{users: users} = state) do
    Enum.each(users, fn pid ->
      send(pid, {:new_message, message})
    end)
    {:noreply, state}
  end
end
