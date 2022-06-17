defmodule FoodElxproWeb.CartLive do
  use FoodElxproWeb, :live_view

  alias __MODULE__.{CartDetail, EmptyCart}
  alias FoodElxpro.Carts

  def mount(_p, _s, socket) do
    cart_id = socket.assigns.cart_id
    cart = Carts.get(cart_id)
    {:ok, assign(socket, cart: cart)}
  end
end
