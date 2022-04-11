defmodule FoodElxproWeb.Admin.ProductLive do
  use FoodElxproWeb, :live_view
  alias FoodElxpro.Products
  alias FoodElxproWeb.Admin.Products.Form

  def mount(_p, _s, socket) do
    products = Products.list_products()
    {:ok, socket |> assign(products: products)}
  end
end
