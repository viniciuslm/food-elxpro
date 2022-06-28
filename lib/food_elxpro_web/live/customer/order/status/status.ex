defmodule FoodElxproWeb.Customer.OrderLive.Status do
  use FoodElxproWeb, :live_view
  alias FoodElxpro.Orders

  @impl true
  def mount(_, _, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _uri, socket) do
    if connected?(socket) do
      Orders.subscribe_update_orders(id)
    end

    current_user = socket.assigns.current_user
    order = Orders.get_order_by_id_and_customer_id(id, current_user.id)
    status_list = Orders.get_status_list()
    current_status = order.status

    socket =
      socket
      |> assign(order: order)
      |> assign(status_list: status_list)
      |> assign(current_status: current_status)

    {:noreply, socket}
  end
end
