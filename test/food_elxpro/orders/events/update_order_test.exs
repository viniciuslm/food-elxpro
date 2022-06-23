defmodule FoodElxpro.Orders.Events.UpdateOrderTest do
  use FoodElxpro.DataCase
  alias FoodElxpro.Orders.Events.UpdateOrder

  test "subscribe_admin_update_orders" do
    UpdateOrder.subscribe_admin_update_orders()
    assert {:messages, []} == Process.info(self(), :messages)

    UpdateOrder.broadcast_admin_update_orders({:ok, %{status: :PREPARING}}, :RECEIVED)
    #  {:ok, %{status: :PREPARING}}, :RECEIVE)
    assert {:messages, [{:order_udpated, %{status: :PREPARING}, :RECEIVED}]} =
             Process.info(self(), :messages)
  end

  test "subscribe_update_user_row" do
    user_id = "123"
    UpdateOrder.subscribe_update_user_row(user_id)
    assert {:messages, []} == Process.info(self(), :messages)

    UpdateOrder.broadcast_update_user_row({:ok, %{status: :PREPARING, user_id: user_id}})
    #  {:ok, %{status: :PREPARING}}, :RECEIVE)
    assert {:messages,
            [
              update_order_user_row: %{
                status: :PREPARING,
                user_id: "123"
              }
            ]} = Process.info(self(), :messages)
  end

  test "subscribe_update_orders" do
    order_id = "123"
    UpdateOrder.subscribe_update_orders(order_id)
    assert {:messages, []} == Process.info(self(), :messages)

    UpdateOrder.broadcast_update_order({:ok, %{id: order_id, status: :PREPARING}})

    #  {:ok, %{status: :PREPARING}}, :RECEIVE)
    assert {:messages, [{:update_order, %{status: :PREPARING, id: "123"}}]} =
             Process.info(self(), :messages)
  end
end
