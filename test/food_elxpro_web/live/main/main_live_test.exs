defmodule FoodElxproWeb.MainLiveTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  alias FoodElxproWeb.Router.Helpers, as: Routes

  test "load page", %{conn: conn} do
    {:ok, view, html} = live(conn, Routes.main_path(conn, :index))

    assert html =~ "Make your order"
    assert render(view) =~ "Make your order"
  end
end
