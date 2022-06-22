defmodule FoodElxpro.Orders do
  alias FoodElxpro.Orders.Core.AllStatusOrders
  alias FoodElxpro.Orders.Events.NewOrder

  defdelegate all_status_orders, to: AllStatusOrders, as: :execute
  defdelegate subscribe_to_receive_new_orders, to: NewOrder, as: :subscribe
end
