defmodule FoodElxproWeb.CartLive do
  use FoodElxproWeb, :live_view

  alias __MODULE__.{CartDetail, EmptyCart}

  def mount(_p, _s, socket) do
    {:ok, socket}
  end
end
