defmodule FoodElxproWeb.Main.ItemsTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  alias FoodElxproWeb.Router.Helpers, as: Routes

  test "load items", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.main_path(conn, :index))
    assert has_element?(view, "#items-component")
    assert has_element?(view, "[data-role=items-info][data-id=all-foods]", "All foods")
  end
end
