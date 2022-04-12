defmodule FoodElxproWeb.Admin.Products.Form do
  use FoodElxproWeb, :live_component
  alias FoodElxpro.Products
  alias FoodElxpro.Products.Product

  def update(assigns, socket) do
    changeset = Products.change_product()

    {:ok,
     socket
     |> assign(assigns)
     |> assign(changeset: changeset)
     |> assign(product: %Product{})}
  end

  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Products.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Products.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end
end
