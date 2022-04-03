defmodule FoodElxproWeb.Main.HeroTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  alias FoodElxproWeb.Router.Helpers, as: Routes

  test "load hero", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.main_path(conn, :index))
    assert has_element?(view, "#hero-component")
    assert has_element?(view, "[data-role=hero-info]")
    assert has_element?(view, "[data-id=recomendation]", "Make your order")
    assert has_element?(view, "[data-id=cta]", "We are waiting for you!!")
    assert has_element?(view, "[data-id=cta-action]", "Order Now")
  end
end
