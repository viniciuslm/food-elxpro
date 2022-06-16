defmodule FoodElxproWeb.Admin.ProductLive do
  use FoodElxproWeb, :live_view
  alias FoodElxpro.Products
  alias FoodElxpro.Products.Product
  alias FoodElxproWeb.Admin.Product.FilterByName
  alias FoodElxproWeb.Admin.Product.Paginate
  alias FoodElxproWeb.Admin.Product.ProductRow
  alias FoodElxproWeb.Admin.Product.SelectPerPage
  alias FoodElxproWeb.Admin.Product.Sort
  alias FoodElxproWeb.Admin.Products.Form

  @impl true
  def mount(_p, _s, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    name = params["name"] || ""

    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "5")
    total = Products.count_products(name: name)
    paginate = %{page: page, per_page: per_page, total: total}

    sort_by = (params["sort_by"] || "updated_at") |> String.to_atom()
    sort_order = (params["sort_order"] || "desc") |> String.to_atom()
    sort = %{sort_by: sort_by, sort_order: sort_order}

    live_action = socket.assigns.live_action
    products = Products.list_products(paginate: paginate, name: name, sort: sort)

    assigns = [products: products, name: name, loading: false, options: sort, names: []]

    options = Map.merge(paginate, sort)

    socket =
      socket
      |> apply_action(live_action, params)
      |> assign(assigns)
      |> assign(options: options)

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
  def handle_event("suggest", %{"name" => name}, socket) do
    names = Products.list_suggest_names(name)
    {:noreply, assign(socket, names: names)}
  end

  @impl true
  def handle_info({:list_products, name}, socket) do
    sort = %{
      sort_by: socket.assigns.options.sort_by,
      sort_order: socket.assigns.options.sort_order
    }

    paginate = %{page: socket.assigns.options.page, per_page: socket.assigns.options.per_page}
    params = [name: name, sort: sort, paginate: paginate]
    {:noreply, perfom_filter(socket, params)}
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

  defp perfom_filter(socket, params) do
    Products.list_products(params)
    |> return_filter_response(socket, params)
  end

  defp return_filter_response([], socket, params) do
    assigns = [products: [], loading: false, name: params[:name]]
    name = params[:name]

    socket
    |> put_flash(:info, "There is no procuct with \"#{name}\"")
    |> assign(assigns)
  end

  defp return_filter_response(products, socket, _params) do
    assigns = [products: products, loading: false]

    socket
    |> assign(assigns)
  end
end
