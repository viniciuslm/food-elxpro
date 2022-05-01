defmodule FoodElxproWeb.Admin.Products.FormTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodElxpro.Factory
  alias FoodElxpro.Products

  setup :register_and_log_in_user_admin

  test "load modal insert product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)

    assert has_element?(view, "[data-role=modal]")
    assert has_element?(view, "[data-role=product-form]")

    assert view |> form("#new", product: %{name: nil}) |> render_change() =~
             "can&#39;t be blank"
  end

  test "load modal and close modal", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)

    assert view |> has_element?("#modal")
    assert view |> has_element?("#close")
  end

  test "give a product when submit the form then return a message that has created the product",
       %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)

    payload = %{
      name: "teste produto",
      description: "teste de produto",
      price: 123,
      size: "small"
    }

    {:ok, _, html} =
      view
      |> form("#new",
        product: payload
      )
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product has created!"
  end

  test "give a product when submit the form then return changeset error",
       %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)

    payload = %{
      name: "teste produto",
      description: "teste de produto",
      price: 123,
      size: "small"
    }

    {:ok, _product} = Products.create_product(payload)

    assert view
           |> form("#new",
             product: payload
           )
           |> render_submit() =~ "has already been taken"
  end

  test "give a product that has already exist when click to edit then open modal and show an error",
       %{conn: conn} do
    product = insert(:product)
    product_2 = insert(:product)

    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert view |> element("[data-role=edit-product][data-id=#{product.id}]") |> render_click()
    assert view |> has_element?("#modal")

    assert_patch(view, Routes.admin_product_path(conn, :edit, product))

    assert view |> form("##{product.id}", product: %{name: product_2.name}) |> render_submit() =~
             "has already been taken"
  end

  test "give a product that has already exist when click to edit then open modal and execute an action",
       %{conn: conn} do
    product = insert(:product)

    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert view |> element("[data-role=edit-product][data-id=#{product.id}]") |> render_click()
    assert view |> has_element?("#modal")

    assert_patch(view, Routes.admin_product_path(conn, :edit, product))

    {:ok, view, html} =
      view
      |> form("##{product.id}",
        product: %{name: "teste 2"}
      )
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product updated!"
    assert view |> has_element?("[data-role=product-item][data-id=#{product.id}]")
    assert view |> has_element?("[data-role=product-name][data-id=#{product.id}]", "teste 2")
  end

  defp open_modal(view) do
    view
    |> element("[data-role=add-new-product]", "New")
    |> render_click()
  end
end
