defmodule FoodElxproWeb.Admin.Products.Form do
  use FoodElxproWeb, :live_component
  alias FoodElxpro.Products

  def update(assigns, socket) do
    changeset = Products.change_product()

    {:ok,
     socket
     |> assign(assigns)
     |> assign(changeset: changeset)}
  end
end
