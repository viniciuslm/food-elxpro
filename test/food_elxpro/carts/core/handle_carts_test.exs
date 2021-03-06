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
      assert @start_cart == create_cart(4444)
    end

    test "should add a new item in the cart" do
      product = insert(:product)

      cart = add(@start_cart, product)

      assert 1 == cart.total_qty
      assert [%{item: product, qty: 1}] == cart.items
      assert product.price == cart.total_price
    end

    test "should add the same item twice in the cart" do
      product = insert(:product)

      cart =
        @start_cart
        |> add(product)
        |> add(product)

      assert 2 == cart.total_qty
      assert [%{item: product, qty: 2}] == cart.items
      assert Money.multiply(product.price, 2) == cart.total_price
    end

    test "should remove an item" do
      product = insert(:product)
      product_2 = insert(:product)

      cart =
        @start_cart
        |> add(product)
        |> add(product)
        |> add(product_2)

      total_price =
        product.price
        |> Money.multiply(2)
        |> Money.add(product_2.price)

      assert 3 == cart.total_qty
      assert [%{item: product, qty: 2}, %{item: product_2, qty: 1}] == cart.items
      assert total_price == cart.total_price

      cart = cart |> remove(product.id)

      assert 1 == cart.total_qty
      assert [%{item: product_2, qty: 1}] == cart.items
      assert product_2.price == cart.total_price
    end

    test "should increment the same element into the cart" do
      product = insert(:product)
      product_2 = insert(:product)

      cart =
        @start_cart
        |> add(product)
        |> add(product)
        |> add(product_2)
        |> inc(product.id)

      total_price =
        product.price
        |> Money.multiply(3)
        |> Money.add(product_2.price)

      assert 4 == cart.total_qty
      assert [%{item: product_2, qty: 1}, %{item: product, qty: 3}] == cart.items
      assert total_price == cart.total_price
    end

    test "should decrement the same element into the cart" do
      product = insert(:product)
      product_2 = insert(:product)

      cart =
        @start_cart
        |> add(product)
        |> add(product)
        |> add(product_2)
        |> dec(product.id)

      total_price =
        product.price
        |> Money.add(product_2.price)

      assert 2 == cart.total_qty
      assert [%{item: product_2, qty: 1}, %{item: product, qty: 1}] == cart.items
      assert total_price == cart.total_price
    end

    test "should decrement all elements into the cart" do
      product = insert(:product)

      cart =
        @start_cart
        |> add(product)
        |> add(product)
        |> dec(product.id)
        |> dec(product.id)

      assert 0 == cart.total_qty
      assert [] == cart.items
      assert Money.new(0) == cart.total_price
    end
  end
end
