defmodule FoodElxproWeb.Admin.OrderLive.Layer do
  use FoodElxproWeb, :live_component
  alias __MODULE__.Card
  alias FoodElxpro.Orders

  def update(%{id: id} = assigns, socket) do
    cards = Orders.list_orders_by_status(id)

    {:ok, socket |> assign(assigns) |> assign(cards: cards)}
  end
end
