defmodule FoodElxpro.Orders do
  alias FoodElxpro.Orders.Core.{
    AllStatusOrders,
    GetOrderByIdAndCustomerId,
    ListOrdersByStatus,
    ListOrdersByUserId
  }

  alias FoodElxpro.Orders.Events.NewOrder

  defdelegate all_status_orders, to: AllStatusOrders, as: :execute

  defdelegate get_order_by_id_and_customer_id(order_id, customer_id),
    to: GetOrderByIdAndCustomerId,
    as: :execute

  defdelegate list_orders_by_status(status), to: ListOrdersByStatus, as: :execute
  defdelegate list_orders_by_user_id(user_id), to: ListOrdersByUserId, as: :execute
  defdelegate subscribe_to_receive_new_orders, to: NewOrder, as: :subscribe
end
