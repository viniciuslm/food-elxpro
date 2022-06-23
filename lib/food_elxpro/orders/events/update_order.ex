defmodule FoodElxpro.Orders.Events.UpdateOrder do
  alias Phoenix.PubSub

  @pubsub FoodElxpro.PubSub
  @admin_update_orders "admin-update-orders"
  @update_user_row "update-user-row"
  @update_orders "update-orders"

  def subscribe_admin_update_orders, do: PubSub.subscribe(@pubsub, @admin_update_orders)

  def broadcast_admin_update_orders({:ok, order} = result, old_status) do
    PubSub.broadcast(@pubsub, @admin_update_orders, {:order_udpated, order, old_status})
    result
  end

  def subscribe_update_user_row(user_id) do
    PubSub.subscribe(@pubsub, @update_user_row <> "#{user_id}")
  end

  def broadcast_update_user_row({:ok, order} = result) do
    PubSub.broadcast(
      @pubsub,
      @update_user_row <> "#{order.user_id}",
      {:update_order_user_row, order}
    )

    result
  end

  def subscribe_update_orders(order_id) do
    PubSub.subscribe(@pubsub, @update_orders <> "#{order_id}")
  end

  def broadcast_update_order({:ok, order} = result) do
    PubSub.broadcast(
      @pubsub,
      @update_orders <> "#{order.id}",
      {:update_order, order}
    )

    result
  end
end
