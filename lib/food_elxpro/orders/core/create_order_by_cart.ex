defmodule FoodElxpro.Orders.Core.CreateOrderByCart do
  alias FoodElxpro.Carts
  alias FoodElxpro.Orders.Data.Order
  alias FoodElxpro.Repo

  def execute(%{"current_user" => current_user} = payload) do
    current_user
    |> Carts.get()
    |> convert_session_to_payload_item
    |> create_order_payload(payload)
    |> Repo.insert()
    |> remove_cache()
  end

  defp convert_session_to_payload_item(%{items: items} = cart) do
    payload_items = Enum.map(items, &%{quantity: &1.qty, product_id: &1.item.id})
    {cart, payload_items}
  end

  defp create_order_payload({cart, items}, payload) do
    changeset = %{
      user_id: payload["current_user"],
      items: items,
      total_quantity: cart.total_qty,
      total_price: cart.total_price,
      address: payload["address"],
      phone_number: payload["phone_number"]
    }

    Order.changeset(%Order{}, changeset)
  end

  defp remove_cache({:error, _} = err), do: err

  defp remove_cache({:ok, order} = result) do
    result
  end
end
