defmodule FoodElxpro.Orders do
  alias FoodElxpro.Orders.Events.NewOrder

  defdelegate subscribe_to_receive_new_orders, to: NewOrder, as: :subscribe
end
