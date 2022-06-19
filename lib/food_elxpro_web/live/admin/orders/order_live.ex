defmodule FoodElxproWeb.Admin.OrderLive do
  use FoodElxproWeb, :live_view
  alias __MODULE__.SideMenu
  alias __MODULE__.Layer

  @impl true
  def mount(_p, _s, socket) do
    {:ok, socket}
  end
end
