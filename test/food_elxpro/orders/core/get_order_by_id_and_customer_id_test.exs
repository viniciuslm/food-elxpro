defmodule FoodElxpro.Orders.Core.GetOrderByIdAndCustomerIdTest do
  use FoodElxpro.DataCase
  import FoodElxpro.Factory
  alias FoodElxpro.Orders.Core.GetOrderByIdAndCustomerId

  test "return order per id and user_id" do
    order = insert(:order)
    assert order.id == GetOrderByIdAndCustomerId.execute(order.id, order.user_id).id
  end
end
