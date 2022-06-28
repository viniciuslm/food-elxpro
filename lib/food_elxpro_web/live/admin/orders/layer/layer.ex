defmodule FoodElxproWeb.Admin.OrderLive.Layer do
  use FoodElxproWeb, :live_component
  alias __MODULE__.Card
  alias FoodElxpro.Orders

  def update(%{id: id} = assigns, socket) do
    cards = Orders.list_orders_by_status(id)

    {:ok, socket |> assign(assigns) |> assign(cards: cards)}
  end

  def handle_event(
        "dropped",
        %{"new_status" => new_status, "old_status" => old_status},
        socket
      )
      when new_status == old_status do
    {:noreply, socket}
  end

  def handle_event(
        "dropped",
        %{"order_id" => order_id, "new_status" => new_status, "old_status" => old_status},
        socket
      ) do
    Orders.update_order_status(order_id, new_status, old_status)
    {:noreply, socket}
  end
end
