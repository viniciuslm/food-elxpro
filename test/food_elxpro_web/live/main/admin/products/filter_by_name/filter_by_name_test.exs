defmodule FoodElxproWeb.Admin.ProductLive.FilterByNameTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodElxpro.Factory

  describe "test filter" do
    setup :register_and_log_in_user_admin

    test "filter by name", %{conn: conn} do
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
  end
end
