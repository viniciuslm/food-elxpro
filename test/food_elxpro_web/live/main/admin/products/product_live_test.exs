defmodule FoodElxproWeb.Admin.ProductLiveTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodElxpro.Factory

  test "load page", %{conn: conn} do
    product = insert(:product)

    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
    assert has_element?(view, "[data-role=product-section]")
    assert has_element?(view, "[data-role=product-table]")
    assert has_element?(view, "[data-id=head-name]", "Name")
    assert has_element?(view, "[data-id=head-price]", "Price")
    assert has_element?(view, "[data-id=head-size]", "Size")
    assert has_element?(view, "[data-id=head-actions]", "Actions")
    assert has_element?(view, "[data-role=product-list]")

    # Test product
    assert has_element?(view, "[data-role=product-item][data-id=#{product.id}]")
    assert has_element?(view, "[data-role=product-name][data-id=#{product.id}]", product.name)

    assert has_element?(
             view,
             "[data-role=product-price][data-id=#{product.id}]",
             Money.to_string(product.price)
           )

    assert has_element?(view, "[data-role=product-size][data-id=#{product.id}]", product.size)
  end

  test "give a product that has exist when click to delete then return a message that has deleted the product",
       %{conn: conn} do
    product = insert(:product)

    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert view |> has_element?("[data-role=delete-product][data-id=#{product.id}]", "Delete")

    {:ok, view, _html} =
      view
      |> element("[data-role=delete-product][data-id=#{product.id}]", "Delete")
      |> render_click()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    refute view |> has_element?("[data-role=delete-product][data-id=#{product.id}]", "Delete")
  end
end
