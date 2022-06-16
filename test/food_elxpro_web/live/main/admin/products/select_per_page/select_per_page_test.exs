defmodule FoodElxproWeb.Admin.ProductLive.SelectPerPageTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodElxpro.Factory

  setup :register_and_log_in_user_admin

  test "select per page",
       %{conn: conn} do
    for _ <- 1..2, do: insert(:product)

    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    view
    |> form("#per-page")
    |> render_change(%{select_per_page: 10})

    # assert_patched(
    #   view,
    #   "/admin/products?page=1&per_page=10&sort_by=updated_at&sort_order=desc&name="
    # )

    # view
    # |> form("#per-page", %{select_per_page: 5})
    # |> render_change()

    # assert_patched(
    #   view,
    #   "/admin/products?page=1&per_page=5&sort_by=updated_at&sort_order=desc&name="
    # )
  end
end
