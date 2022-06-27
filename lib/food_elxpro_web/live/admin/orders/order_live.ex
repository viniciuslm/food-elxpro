defmodule FoodElxproWeb.Admin.OrderLive do
  use FoodElxproWeb, :live_view
  alias __MODULE__.Layer
  alias __MODULE__.SideMenu
  alias FoodElxpro.Orders

  @impl true
  def mount(_p, _s, socket) do
    if connected?(socket) do
      Orders.subscribe_admin_update_orders()
      Orders.subscribe_to_receive_new_orders()
    end

    {:ok, socket}
  end
end
