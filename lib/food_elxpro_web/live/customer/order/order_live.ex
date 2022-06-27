defmodule FoodElxproWeb.Customer.OrderLive do
  use FoodElxproWeb, :live_view

  @impl true
  def mount(_, _, socket) do
    {:ok, socket}
  end
end
