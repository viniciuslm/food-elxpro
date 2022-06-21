defmodule FoodElxpro.Orders.Core.CreateOrderByCartTest do
  use FoodElxpro.DataCase

  import FoodElxpro.AccountsFixtures
  import FoodElxpro.ProductFixtures

  alias FoodElxpro.Carts
  alias FoodElxpro.Orders.Core.CreateOrderByCart

  test "create_order_by_cart with sucess" do
    product = product_fixture()
    user = user_fixture()
    assert :ok == Carts.create(user.id)
    assert 1 == Carts.add(user.id, product).total_qty

    payload = %{
      "address" => "123",
      "current_user" => user.id,
      "phone_number" => "3232"
    }

    {:ok, result} = CreateOrderByCart.execute(payload)
    assert 1 == result.total_quantity
    assert 0 == Carts.get(user.id).total_qty
  end
end
