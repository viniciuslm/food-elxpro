defmodule FoodElxpro.Core.HandleCartsTest do
  use FoodElxpro.DataCase

  alias FoodElxpro.Carts.Core.HandleCarts
  alias FoodElxpro.Carts.Data.Cart

  describe "handle carts" do
    test "should create a new cart" do
      assert %Cart{
               id: 4444,
               items: [],
               total_items: 0,
               total_price: %Money{amount: 0, currency: :BRL},
               total_qty: 0
             } == HandleCarts.create_carts(4444)
    end
  end
end
