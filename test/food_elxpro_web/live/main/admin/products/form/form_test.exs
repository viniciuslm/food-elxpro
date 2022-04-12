defmodule FoodElxproWeb.Admin.Products.FormTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  alias FoodElxpro.Products

  test "load modal insert product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert has_element?(view, "[data-role=modal]")
    assert has_element?(view, "[data-role=product-form]")

    assert view |> form("#new_product", product: %{name: nil}) |> render_change() =~
             "can&#39;t be blank"
  end

  test "give a product when submit the form then return a message that has created the product",
       %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    payload = %{
      name: "teste produto",
      description: "teste de produto",
      price: 123,
      size: "small"
    }

    {:ok, _, html} =
      view
      |> form("#new_product",
        product: payload
      )
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product has created!"
  end

  test "give a product when submit the form then return changeset error",
       %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    payload = %{
      name: "teste produto",
      description: "teste de produto",
      price: 123,
      size: "small"
    }

    {:ok, _product} = Products.create_product(payload)

    assert view
           |> form("#new_product",
             product: payload
           )
           |> render_submit() =~ "has already been taken"
  end
end
