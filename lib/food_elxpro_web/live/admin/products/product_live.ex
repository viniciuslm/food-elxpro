defmodule FoodElxproWeb.Admin.ProductLive do
  use FoodElxproWeb, :live_view
  alias FoodElxpro.Products
  alias FoodElxpro.Products.Product
  alias FoodElxproWeb.Admin.Product.FilterByName
  alias FoodElxproWeb.Admin.Product.ProductRow
  alias FoodElxproWeb.Admin.Product.Sort
  alias FoodElxproWeb.Admin.Products.Form

  @impl true
  def mount(_p, _s, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    name = params["name"] || ""
    sort_by = (params["sort_by"] || "updated_at") |> String.to_atom()
    sort_order = (params["sort_order"] || "desc") |> String.to_atom()

    sort = %{sort_by: sort_by, sort_order: sort_order}

    live_action = socket.assigns.live_action
    products = Products.list_products(name: name, sort: sort)

    assigns = [products: products, name: name, loading: false, options: sort]

    socket =
      socket
      |> apply_action(live_action, params)
      |> assign(assigns)

    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    delete(socket, id)
  end

  @impl true
  def handle_event("filter-by-name", %{"name" => name}, socket) do
    socket = apply_filters(socket, name)
    {:noreply, socket}
  end

  @impl true
  def handle_info({:list_products, name}, socket) do
    {:noreply, perfom_filter(socket, name)}
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

  defp apply_filters(socket, name) do
    assigns = [products: [], name: name, loading: true]

    send(self(), {:list_products, name})

    assign(socket, assigns)
  end

  defp perfom_filter(socket, name) do
    Products.list_products(name: name)
    |> return_filter_response(socket, name)
  end

  defp return_filter_response([], socket, name) do
    assigns = [products: [], loading: false]

    socket
    |> put_flash(:info, "There is no procuct with \"#{name}\"")
    |> assign(assigns)
  end

  defp return_filter_response(products, socket, _name) do
    assigns = [products: products, loading: false]

    socket
    |> assign(assigns)
  end
end
