defmodule FoodElxproWeb.FirstLive do
  use FoodElxproWeb, :live_view
  alias FoodElxproWeb.First.IncComponent

  def mount(_assign, _session, socket) do
    components = [1, 2, 3, 4, 5]
    total = components |> Enum.sum()
    component = 1
    {:ok, socket |> assign(components: components, total: total, component: component)}
  end

  def handle_info(:inc_parent, socket) do
    {:noreply, socket |> update(:total, fn x -> x + 1 end)}
  end

  def handle_event("save", %{"form" => %{"component" => component}}, socket) do
    send_update(IncComponent, id: "inc-" <> component, inc: 1)
    {:noreply, socket |> update(:total, fn x -> x + 1 end) |> update(:component, fn _ -> component end)}
  end
end
