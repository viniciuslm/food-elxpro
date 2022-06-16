defmodule FoodElxpro.Carts.Core.HandleCarts do
  alias FoodElxpro.Carts.Data.Cart

  def create_carts(id), do: Cart.new(id)

  def add_new_product(cart, item) do
    new_toral_price = Money.add(cart.total_price, item.price)

    %{
      cart
      | total_qty: cart.total_qty + 1,
        total_items: cart.total_items + 1,
        items: cart.items ++ [item],
        total_price: new_toral_price
    }
  end
end
