defmodule FoodElxproWeb.MainLive do
  use FoodElxproWeb, :live_view

  def mount(_assigns, _session, socket) do
    {:ok, socket |>  assign(name: "Vinicius", age: 44)}
  end
end
