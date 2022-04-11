defmodule FoodElxproWeb.Admin.Products.FormTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest

  test "load modal insert product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert has_element?(view, "[data-role=modal]")
    assert has_element?(view, "[data-role=product-form]")

    assert view |> form("#new_product", product: %{name: nil}) |> render_change() =~
             "can&#39;t be blank"
  end
end
