defmodule ChatUI do
  use N2O, with: [:nitro]

  # Головна сторінка
  def index do
    Nitro.page([
      Nitro.button(id: "room1", body: "Кімната 1", postback: "room1"),
      Nitro.button(id: "room2", body: "Кімната 2", postback: "room2"),
      Nitro.button(id: "room3", body: "Кімната 3", postback: "room3")
    ])
  end

  # Сторінка кімнати
  def room(room) do
    Nitro.page([
      Nitro.input(id: "message_input", placeholder: "Введіть повідомлення"),
      Nitro.button(id: "send_button", body: "Надіслати", postback: "send"),
      Nitro.div(id: "messages", body: "Повідомлення тут з'являтимуться")
    ])
  end
end
