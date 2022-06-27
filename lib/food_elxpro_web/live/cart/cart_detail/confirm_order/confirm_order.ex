defmodule FoodElxproWeb.CartLive.CartDetail.ConfirmOrder do
  use FoodElxproWeb, :live_component

  alias FoodElxpro.Orders

  def handle_event("create_order", params, socket) do
    case Orders.create_order_by_cart(params) do
      {:ok, _order} ->
        socket =
          socket
          |> put_flash(:info, "Order create with sucess")
          |> push_redirect(to: Routes.customer_order_path(socket, :index))

        {:noreply, socket}

      {:error, _changeset} ->
        socket =
          socket
          |> put_flash(:error, "Something went wrong, please verify your order")
          |> push_redirect(to: Routes.cart_path(socket, :index))

        {:noreply, socket}
    end
  end
end
