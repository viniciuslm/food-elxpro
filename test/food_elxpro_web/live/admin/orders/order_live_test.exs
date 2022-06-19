defmodule FoodElxproWeb.Admin.OrderLiveTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "test is order loaded" do
    setup :register_and_log_in_user_admin

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))
      assert has_element?(view, "#side-menu")
    end
  end
end
