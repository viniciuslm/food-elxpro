defmodule LiveSessions.Cart do
  import Phoenix.LiveView

  alias FoodElxpro.Accounts
  alias FoodElxpro.Carts

  def on_mount(:default, _, session, socket) do
    cart_id = get_connect_params(socket)["cart_id"]
    user_token = session["user_token"]
    socket = socket |> assign_user(user_token) |> create_cart(cart_id)
    {:cont, socket}
  end

  defp assign_user(socket, nil), do: assign(socket, :current_user, nil)

  defp assign_user(socket, user_token) do
    current_user =
      user_token
      |> Accounts.get_user_by_session_token()

    assign_new(socket, :current_user, fn -> current_user end)
  end

  defp create_cart(socket, cart_id) do
    current_user = socket.assigns.current_user

    cart_id = build_cart_id(current_user, cart_id)

    socket
    |> assign(cart_id: cart_id)
    |> push_event("create-cart-session-id", %{"cartId" => cart_id})
  end

  defp build_cart_id(nil, nil) do
    cart_id = Ecto.UUID.generate()
    return_cart_id(cart_id)
  end

  defp build_cart_id(nil, cart_id), do: return_cart_id(cart_id)

  defp build_cart_id(%{id: cart_id}, _cart_id), do: return_cart_id(cart_id)

  defp return_cart_id(cart_id) do
    Carts.create(cart_id)
    cart_id
  end
end
