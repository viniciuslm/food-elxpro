defmodule FoodElxpro.Orders.Core.ListOrdersByStatus do
  alias FoodElxpro.Orders.Data.Order
  alias FoodElxpro.Repo

  import Ecto.Query

  def execute(status) do
    Order
    |> where([o], o.status == ^status)
    |> order_by([o], desc: o.inserted_at)
    |> preload([o], [:user, items: [:product]])
    |> Repo.all()
  end
end
