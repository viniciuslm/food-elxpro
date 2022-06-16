defmodule FoodElxpro.Carts.Core.HandleCarts do
  alias FoodElxpro.Carts.Data.Cart

  def create_carts(id), do: Cart.new(id)

  def add_new_product(cart, item) do
    new_toral_price = Money.add(cart.total_price, item.price)
    items = cart.items
    new_items = new_item(items, item)

    %{
      cart
      | total_qty: cart.total_qty + 1,
        items: new_items,
        total_price: new_toral_price
    }
  end

  defp new_item(items, item) do
    is_there_item_id? = Enum.find(items, &(&1.item.id == item.id))

    if is_there_item_id? == nil do
      items ++ [%{item: item, qty: 1}]
    else
      items
      |> Map.new(fn item -> {item.item.id, item} end)
      |> Map.update!(item.id, &%{&1 | qty: &1.qty + 1})
      |> Map.values()
    end
  end
end
