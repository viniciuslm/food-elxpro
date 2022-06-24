defmodule LiveSessions.Cart do
  import Phoenix.LiveView

  alias FoodElxpro.Accounts
  alias LiveSessions.CreateCart

  def on_mount(:default, _, session, socket) do
    cart_id = get_connect_params(socket)["cart_id"]
    user_token = session["user_token"]
    socket = socket |> assign_user(user_token) |> CreateCart.execute(cart_id)
    {:cont, socket}
  end

  defp assign_user(socket, nil), do: assign(socket, :current_user, nil)

  defp assign_user(socket, user_token) do
    current_user =
      user_token
      |> Accounts.get_user_by_session_token()

    assign_new(socket, :current_user, fn -> current_user end)
  end
end
