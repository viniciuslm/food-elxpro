defmodule FoodElxproWeb.Admin.ProductLive.ShowTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodElxpro.Factory

  setup :register_and_log_in_user

  test "load page",
       %{conn: conn} do
    product = insert(:product)

    {:ok, view, _html} = live(conn, Routes.admin_product_show_path(conn, :show, product))

    assert view |> has_element?("[data-role=name]", product.name)
    assert view |> has_element?("[data-role=description]", product.description)
    assert view |> has_element?("[data-role=price]", Money.to_string(product.price))
    assert view |> has_element?("[data-role=size]", product.size)
  end
end
