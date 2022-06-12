defmodule FoodElxproWeb.Main.ItemTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodElxpro.Factory

  alias FoodElxproWeb.Router.Helpers, as: Routes

  test "load item", %{conn: conn} do
    product = insert(:product)
    {:ok, view, _html} = live(conn, Routes.main_path(conn, :index))
    assert has_element?(view, "#item-#{product.id}")
    assert has_element?(view, "[data-role=product-img][data-id=item-#{product.id}]")
    assert has_element?(view, "[data-role=product-description]")

    assert has_element?(
             view,
             "[data-role=product-name][data-id=item-#{product.id}]",
             product.name
           )

    assert has_element?(
             view,
             "[data-role=product-price][data-id=item-#{product.id}]",
             Money.to_string(product.price)
           )

    assert has_element?(view, "[data-role=product-add][data-id=item-#{product.id}]")
  end
end
