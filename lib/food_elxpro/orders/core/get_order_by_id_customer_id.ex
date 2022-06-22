defmodule FoodElxpro.Orders.Core.GetOrderByIdAndCustomerId do
  alias FoodElxpro.Orders.Data.Order
  alias FoodElxpro.Repo

  import Ecto.Query

  def execute(order_id, customer_id) do
    Order
    |> where([o], o.id == ^order_id and o.user_id == ^customer_id)
    |> Repo.one()
  end
end
