defmodule FoodElxpro.Core.HandleCartsTest do
  use FoodElxpro.DataCase

  import FoodElxpro.Factory
  import FoodElxpro.Carts.Core.HandleCarts

  alias FoodElxpro.Carts.Data.Cart

  @start_cart %Cart{
    id: 4444,
    items: [],
    total_price: %Money{amount: 0, currency: :BRL},
    total_qty: 0
  }

  describe "handle carts" do
    test "should create a new cart" do
      assert @start_cart == create_carts(4444)
    end

    test "should add a new item in the cart" do
      product = insert(:product)

      cart = add_new_product(@start_cart, product)

      assert 1 == cart.total_qty
      assert [%{item: product, qty: 1}] == cart.items
      assert product.price == cart.total_price
    end

    test "should add the same item twice in the cart" do
      product = insert(:product)

      cart =
        @start_cart
        |> add_new_product(product)
        |> add_new_product(product)

      assert 2 == cart.total_qty
      assert [%{item: product, qty: 2}] == cart.items
      assert Money.multiply(product.price, 2) == cart.total_price
    end
  end
end
