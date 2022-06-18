defmodule LiveSessions.Permissions do
  import Phoenix.LiveView

  alias FoodElxpro.Accounts
  alias FoodElxpro.Carts
  alias FoodElxproWeb.Router.Helpers, as: Routes

  def on_mount(:admin, _params, %{"user_token" => user_token}, socket) do
    cart_id = get_connect_params(socket)["cart_id"]
    assign_user(socket, :admin, user_token, cart_id)
  end

  defp assign_user(socket, _, nil, _), do: error_login(socket, "You must be logged in")

  defp assign_user(socket, :admin, user_token, cart_id) do
    user_token
    |> Accounts.get_user_by_session_token()
    |> return_socket(socket, cart_id)
  end

  defp return_socket(%{role: role}, socket, _) when role != :ADMIN,
    do: error_login(socket, "You don't have permissions to access this page")

  defp return_socket(current_user, socket, cart_id) do
    {:cont, assign_new(socket, :current_user, fn -> current_user end) |> create_cart(cart_id)}
  end

  defp error_login(socket, message) do
    socket =
      socket
      |> put_flash(:error, message)
      |> redirect(to: Routes.main_path(socket, :index))

    {:halt, socket}
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
