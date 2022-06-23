defmodule FoodElxpro.Orders.Core.UpdateOrderStatusTest do
  use FoodElxpro.DataCase
  import FoodElxpro.Factory
  alias FoodElxpro.Orders.Core.UpdateOrderStatus

  test "update status order" do
    order = insert(:order)
    assert {:ok, result} = UpdateOrderStatus.execute(order.id, :RECEIVED, order.status)
    refute order.status == result.status
  end
end
