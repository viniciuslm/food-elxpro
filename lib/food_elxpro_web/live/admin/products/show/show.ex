defmodule FoodElxproWeb.Admin.ProductLive.Show do
  use FoodElxproWeb, :live_view
  alias FoodElxpro.Products

  def mount(_p, _s, socket), do: {:ok, socket}

  def handle_params(%{"id" => id}, _uri, socket) do
    product = Products.get!(id)

    {:noreply,
     socket
     |> assign(product: product)
     |> assign(page_title: "Show Product: #{product.name}")}
  end
end
