defmodule FoodElxproWeb.Admin.ProductLive do
  use FoodElxproWeb, :live_view
  alias FoodElxpro.Products
  alias FoodElxpro.Products.Product
  alias FoodElxproWeb.Admin.Product.ProductRow
  alias FoodElxproWeb.Admin.Products.Form

  def mount(_p, _s, socket) do
    products = Products.list_products()
    {:ok, socket |> assign(products: products)}
  end

  def handle_params(params, _url, socket) do
    live_action = socket.assigns.live_action
    {:noreply, apply_action(socket, live_action, params)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    delete(socket, id)
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Create new Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, _params) do
    socket
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    product = Products.get!(id)

    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, product)
  end

  defp delete(socket, id) do
    {:ok, _} = Products.delete_product(id)

    {:noreply,
     socket
     |> put_flash(:info, "Product deleted!")
     |> push_redirect(to: Routes.admin_product_path(socket, :index))}
  end
end
