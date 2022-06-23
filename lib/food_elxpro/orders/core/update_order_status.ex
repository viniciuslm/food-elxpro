defmodule FoodElxpro.Orders.Core.UpdateOrderStatus do
  alias FoodElxpro.Orders.Data.Order
  alias FoodElxpro.Orders.Events.UpdateOrder
  alias FoodElxpro.Repo

  def execute(order_id, new_status, old_status) do
    Order
    |> Repo.get(order_id)
    |> Order.changeset(%{status: new_status})
    |> Repo.update()
    |> UpdateOrder.broadcast_admin_update_orders(old_status)
    |> UpdateOrder.broadcast_update_order()
    |> UpdateOrder.broadcast_update_user_row()
  end
end
