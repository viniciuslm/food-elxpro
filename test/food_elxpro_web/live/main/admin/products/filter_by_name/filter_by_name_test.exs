defmodule FoodElxproWeb.Admin.ProductLive.FilterByNameTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodElxpro.Factory

  describe "test filter" do
    setup :register_and_log_in_user_admin

    test "filter by name when a sucess", %{conn: conn} do
      product_1 = insert(:product)
      product_2 = insert(:product)

      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

      assert view |> has_element?("[data-role=product-item][data-id=#{product_1.id}]")
      assert view |> has_element?("[data-role=product-item][data-id=#{product_2.id}]")

      view
      |> form("#filter-by-name", %{name: product_1.name})
      |> render_submit

      assert view |> has_element?("[data-role=product-item][data-id=#{product_1.id}]")
      refute view |> has_element?("[data-role=product-item][data-id=#{product_2.id}]")
    end

    test "filter by name when a error", %{conn: conn} do
      product_1 = insert(:product)
      product_2 = insert(:product)
      name = "xpto22"

      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

      assert view |> has_element?("[data-role=product-item][data-id=#{product_1.id}]")
      assert view |> has_element?("[data-role=product-item][data-id=#{product_2.id}]")

      view
      |> form("#filter-by-name", %{name: name})
      |> render_submit

      # assert get_flash(view, :info) =~ "There is no procuct with \"#{name}\""
      refute view |> has_element?("[data-role=product-item][data-id=#{product_1.id}]")
      refute view |> has_element?("[data-role=product-item][data-id=#{product_2.id}]")
    end

    test "suggest an names when type name in filter", %{conn: conn} do
      product_1 = insert(:product)

      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

      assert view |> element("#names") |> render() =~ "<datalist id=\"names\"></datalist>"

      view
      |> form("#filter-by-name")
      |> render_change(%{name: product_1.name})

      assert view |> element("#names") |> render() =~ product_1.name
    end
  end
end
