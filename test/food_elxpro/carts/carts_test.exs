defmodule FoodElxpro.CartsTest do
  use FoodElxpro.DataCase
  import FoodElxpro.Factory
  alias FoodElxpro.Carts

  test "should delete cart" do
    assert :ok == Carts.create(4444)
    assert :ok == Carts.delete(4444)
    assert [] == Carts.get(4444)
  end

  test "should create session" do
    assert :ok == Carts.create(4444)
  end

  test "should create session already existing" do
    assert :ok == Carts.create(4444)
    assert :ok == Carts.create(4444)
  end

  test "should insert a new product" do
    cart_id = Ecto.UUID.generate()
    product = insert(:product)

    assert :ok == Carts.create(cart_id)
    assert 1 == Carts.add(cart_id, product).total_qty
  end

  test "should remove a product" do
    cart_id = Ecto.UUID.generate()
    product = insert(:product)

    assert :ok == Carts.create(cart_id)
    assert 1 == Carts.add(cart_id, product).total_qty
    assert 0 == Carts.remove(cart_id, product.id).total_qty
  end

  test "should increment an item" do
    cart_id = Ecto.UUID.generate()
    product = insert(:product)

    assert :ok == Carts.create(cart_id)
    assert 1 == Carts.add(cart_id, product).total_qty
    assert 2 == Carts.inc(cart_id, product.id).total_qty
  end

  test "should decrement an item" do
    cart_id = Ecto.UUID.generate()
    product = insert(:product)

    assert :ok == Carts.create(cart_id)
    assert 1 == Carts.add(cart_id, product).total_qty
    assert 0 == Carts.dec(cart_id, product.id).total_qty
  end

  test "should get a cart" do
    cart_id = Ecto.UUID.generate()
    product = insert(:product)

    assert :ok == Carts.create(cart_id)
    assert 1 == Carts.add(cart_id, product).total_qty
    assert 1 == Carts.get(cart_id).total_qty
  end
end
