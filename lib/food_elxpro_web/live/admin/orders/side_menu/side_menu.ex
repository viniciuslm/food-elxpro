defmodule FoodElxproWeb.Admin.OrderLive.SideMenu do
  use FoodElxproWeb, :live_component
  alias FoodElxpro.Orders

  def update(assigns, socket) do
    orders_status = Orders.all_status_orders()

    socket =
      socket
      |> assign(assigns)
      |> assign(orders_status: orders_status)

    {:ok, socket}
  end
end
