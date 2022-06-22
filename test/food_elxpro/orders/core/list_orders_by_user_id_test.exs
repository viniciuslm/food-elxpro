defmodule FoodElxpro.Orders.Core.ListOrdersByUserIdTest do
  use FoodElxpro.DataCase
  import FoodElxpro.Factory
  alias FoodElxpro.Orders.Core.ListOrdersByUserId

  test "return orders by user_id" do
    order = insert(:order)
    assert 1 == ListOrdersByUserId.execute(order.user_id) |> Enum.count()
  end
end
