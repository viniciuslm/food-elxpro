defmodule FoodElxproWeb.Customer.OrderLive do
  use FoodElxproWeb, :live_view
  alias __MODULE__.OrderNow
  alias FoodElxpro.Orders

  @impl true
  def mount(_, _, socket) do
    current_user = socket.assigns.current_user

    if connected?(socket) do
      Orders.subscribe_update_user_row(current_user.id)
    end

    orders = Orders.list_orders_by_user_id(current_user.id)

    {:ok, assign(socket, orders: orders)}
  end
end
