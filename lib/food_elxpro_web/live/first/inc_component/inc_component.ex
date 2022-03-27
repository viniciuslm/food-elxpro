defmodule FoodElxproWeb.First.IncComponent do
  use FoodElxproWeb, :live_component

  def update(%{inc: value}, socket) do
    {:ok, socket |> update(:value, fn x -> x + value end)}
  end

  def update(assign, socket) do
    {:ok, socket |> assign(assign)}
  end

  def handle_event("increment", _, socket) do
    send(self(), :inc_parent)
    {:noreply, socket |> update(:value, fn x -> x + 1 end)}
  end
end
