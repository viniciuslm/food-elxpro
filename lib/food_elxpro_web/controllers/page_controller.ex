defmodule FoodElxproWeb.PageController do
  use FoodElxproWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
