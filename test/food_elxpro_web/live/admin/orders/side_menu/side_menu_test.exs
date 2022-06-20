defmodule FoodElxproWeb.Admin.OrderLive.SideMenuTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "test is side menu loaded" do
    setup :register_and_log_in_user_admin

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))
      assert has_element?(view, "#side-menu")
      assert has_element?(view, "[data-role=side-title]", "Orders")

      assert has_element?(view, "[data-role=all-orders]", "All")
      assert has_element?(view, "[data-role=all-orders-qty]", "30")

      assert has_element?(view, "[data-role=all-not-started]", "Not Started")
      assert has_element?(view, "[data-role=all-not-started-qty]", "3")

      assert has_element?(view, "[data-role=all-received]", "Received")
      assert has_element?(view, "[data-role=all-received-qty]", "5")

      assert has_element?(view, "[data-role=all-preparing]", "Preparing")
      assert has_element?(view, "[data-role=all-preparing-qty]", "3")

      assert has_element?(view, "[data-role=all-delivering]", "Delivering")
      assert has_element?(view, "[data-role=all-delivering-qty]", "2")

      assert has_element?(view, "[data-role=all-delivered]", "Delivered")
      assert has_element?(view, "[data-role=all-delivered-qty]", "20")
    end
  end
end
