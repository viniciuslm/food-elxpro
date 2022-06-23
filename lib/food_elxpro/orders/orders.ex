defmodule FoodElxpro.Orders do
  alias FoodElxpro.Orders.Core.{
    AllStatusOrders,
    GetOrderByIdAndCustomerId,
    ListOrdersByStatus,
    ListOrdersByUserId,
    UpdateOrderStatus
  }

  alias FoodElxpro.Orders.Events.{NewOrder, UpdateOrder}

  defdelegate all_status_orders, to: AllStatusOrders, as: :execute

  defdelegate get_order_by_id_and_customer_id(order_id, customer_id),
    to: GetOrderByIdAndCustomerId,
    as: :execute

  defdelegate list_orders_by_status(status), to: ListOrdersByStatus, as: :execute
  defdelegate list_orders_by_user_id(user_id), to: ListOrdersByUserId, as: :execute

  defdelegate subscribe_to_receive_new_orders, to: NewOrder, as: :subscribe
  defdelegate subscribe_admin_update_orders, to: UpdateOrder
  defdelegate subscribe_update_orders(order_id), to: UpdateOrder
  defdelegate subscribe_update_user_row(user_id), to: UpdateOrder

  defdelegate update_order_status(order_id, new_status, old_status),
    to: UpdateOrderStatus,
    as: :execute
end
