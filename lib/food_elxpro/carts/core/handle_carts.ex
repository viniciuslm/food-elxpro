defmodule FoodElxpro.Carts.Core.HandleCarts do
  alias FoodElxpro.Carts.Data.Cart

  def create_carts(id), do: Cart.new(id)
end
