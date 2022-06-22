defmodule FoodElxpro.Orders.Core.ListOrdersByUserId do
  alias FoodElxpro.Orders.Data.Order
  alias FoodElxpro.Repo

  import Ecto.Query

  def execute(user_id) do
    Order
    |> where([o], o.user_id == ^user_id)
    |> order_by([o], desc: o.inserted_at)
    |> preload([o], items: [:product])
    |> Repo.all()
  end
end
