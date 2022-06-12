defmodule FoodElxproWeb.Main.Items do
  use FoodElxproWeb, :live_component
  alias FoodElxproWeb.Main.Items.Item
  alias FoodElxpro.Products

  def update(assigns, socket) do
    products = Products.list_products()
    socket = socket |> assign(assigns) |> assign(products: products)
    {:ok, socket}
  end
end
