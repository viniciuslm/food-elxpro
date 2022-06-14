defmodule FoodElxproWeb.Admin.ProductLiveTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodElxpro.Factory

  setup :register_and_log_in_user_admin

  test "load page", %{conn: conn} do
    product = insert(:product)

    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
    assert has_element?(view, "[data-role=product-section]")
    assert has_element?(view, "[data-role=product-table]")
    assert has_element?(view, "[data-id=head-name]")
    assert has_element?(view, "[data-id=head-price]")
    assert has_element?(view, "[data-id=head-size]")
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

  test "give a product that has exist when click to show and load show page",
       %{conn: conn} do
    product = insert(:product)

    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert view |> has_element?("[data-role=show-product][data-id=#{product.id}]", "Show")

    {:ok, view, _html} =
      view
      |> element("[data-role=show-product][data-id=#{product.id}]", "Show")
      |> render_click()
      |> follow_redirect(conn, Routes.admin_product_show_path(conn, :show, product))

    assert view |> has_element?("[data-role=name]", product.name)
    assert view |> has_element?("[data-role=description]", product.description)
    assert view |> has_element?("[data-role=price]", Money.to_string(product.price))
    assert view |> has_element?("[data-role=size]", product.size)
  end

  test "click sorting by patches",
       %{conn: conn} do
    insert(:product)

    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    view
    |> element("[data-role=sort][data-id=name]")
    |> render_click()

    assert_patched(view, "/admin/products?sort_by=name&sort_order=asc&name=")

    view
    |> element("[data-role=sort][data-id=name]")
    |> render_click()

    assert_patched(view, "/admin/products?sort_by=name&sort_order=desc&name=")
  end

  # test "click sorting by url",
  #      %{conn: conn} do
  #   for _ <- 1..10, do: insert(:product)

  #   {:ok, view, _html} = live(conn, "/admin/products?sort_by=name&sort_order=asc&name=")
  # end
end
