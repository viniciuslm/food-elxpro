defmodule FoodElxpro.Orders.Core.ListOrdersByStatusTest do
  use FoodElxpro.DataCase
  import FoodElxpro.Factory
  alias FoodElxpro.Orders.Core.ListOrdersByStatus

  test "return orders by status" do
    insert(:order)
    assert 1 == ListOrdersByStatus.execute(:NOT_STARTED) |> Enum.count()
  end
end
