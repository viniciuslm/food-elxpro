defmodule FoodElxproWeb.Admin.OrderLive.SideMenuTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  alias FoodElxpro.Orders

  describe "test is side menu loaded" do
    setup :register_and_log_in_user_admin

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))
      all_status_orders = Orders.all_status_orders()

      assert has_element?(view, "#side-menu")
      assert has_element?(view, "[data-role=side-title]", "Orders")

      assert has_element?(view, "[data-role=all-orders]", "All")

      assert has_element?(
               view,
               "[data-role=all-orders-qty]",
               Integer.to_string(all_status_orders.all)
             )

      assert has_element?(view, "[data-role=all-not-started]", "Not Started")

      assert has_element?(
               view,
               "[data-role=all-not-started-qty]",
               Integer.to_string(all_status_orders.not_started)
             )

      assert has_element?(view, "[data-role=all-received]", "Received")

      assert has_element?(
               view,
               "[data-role=all-received-qty]",
               Integer.to_string(all_status_orders.received)
             )

      assert has_element?(view, "[data-role=all-preparing]", "Preparing")

      assert has_element?(
               view,
               "[data-role=all-preparing-qty]",
               Integer.to_string(all_status_orders.preparing)
             )

      assert has_element?(view, "[data-role=all-delivering]", "Delivering")

      assert has_element?(
               view,
               "[data-role=all-delivering-qty]",
               Integer.to_string(all_status_orders.delivering)
             )

      assert has_element?(view, "[data-role=all-delivered]", "Delivered")

      assert has_element?(
               view,
               "[data-role=all-delivered-qty]",
               Integer.to_string(all_status_orders.delivered)
             )
    end
  end
end
