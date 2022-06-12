defmodule FoodElxproWeb.Main.Items do
  use FoodElxproWeb, :live_component
  alias FoodElxpro.Products
  alias FoodElxproWeb.Main.Items.Item

  def update(assigns, socket) do
    products = Products.list_products()
    socket = socket |> assign(assigns) |> assign(products: products)
    {:ok, socket}
  end
end
