defmodule FoodElxproWeb.Admin.OrderLive do
  use FoodElxproWeb, :live_view
  alias __MODULE__.Layer
  alias __MODULE__.SideMenu
  alias FoodElxpro.Orders
  @side_memu_id "side-menu"

  @impl true
  def mount(_p, _s, socket) do
    if connected?(socket) do
      Orders.subscribe_admin_update_orders()
      Orders.subscribe_to_receive_new_orders()
    end

    {:ok, assign(socket, side_memu_id: @side_memu_id)}
  end

  @impl true
  def handle_info({:order_udpated, %{status: new_status}, old_status}, socket) do
    send_update(Layer, id: old_status)
    send_update(Layer, id: Atom.to_string(new_status))
    send_update(SideMenu, id: @side_memu_id)
    {:noreply, socket}
  end
end
