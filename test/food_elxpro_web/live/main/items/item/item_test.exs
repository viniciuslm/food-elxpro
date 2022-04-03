defmodule FoodElxproWeb.Main.ItemTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  alias FoodElxproWeb.Router.Helpers, as: Routes

  test "load item", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.main_path(conn, :index))
    assert has_element?(view, "#item-1")
    assert has_element?(view, "[data-role=product-img][data-id=item-1]")
    assert has_element?(view, "[data-role=product-description]")
    assert has_element?(view, "[data-role=product-name][data-id=item-1]", "Produto com Nome")
    assert has_element?(view, "[data-role=product-price][data-id=item-1]", "$ 10")
    assert has_element?(view, "[data-role=product-add][data-id=item-1]")
  end
end
