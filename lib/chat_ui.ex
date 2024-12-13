defmodule ChatUI do
  # use N2O, with: [:nitro]
  import NITRO

  # Головна сторінка
  def index do
    NITRO.panel([
      NITRO.button(id: "room1", body: "Кімната 1", postback: "room1"),
      NITRO.button(id: "room2", body: "Кімната 2", postback: "room2"),
      NITRO.button(id: "room3", body: "Кімната 3", postback: "room3")
    ])
  end

  # Сторінка кімнати
  def room(room) do
    NITRO.panel([
      NITRO.input(id: "message_input", placeholder: "Введіть повідомлення"),
      NITRO.button(id: "send_button", body: "Надіслати", postback: "send"),
      NITRO.div(id: "messages", body: "Повідомлення тут з'являтимуться")
    ])
  end
end
