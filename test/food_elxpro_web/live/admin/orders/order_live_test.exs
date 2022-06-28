defmodule FoodElxproWeb.Admin.OrderLiveTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodElxpro.Factory
  alias FoodElxpro.Orders

  describe "test is order loaded" do
    setup :register_and_log_in_user_admin

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))
      assert has_element?(view, "#side-menu")
      assert has_element?(view, "[data-role=layers]")
      assert has_element?(view, "#NOT_STARTED")
      assert has_element?(view, "#RECEIVED")
      assert has_element?(view, "#PREPARING")
      assert has_element?(view, "#DELIVERING")
      assert has_element?(view, "#DELIVERED")
    end

    test "change card to another place", %{conn: conn} do
      order = insert(:order)
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))

      assert has_element?(view, "[data-role=order-status][data-id=NOT_STARTED#{order.id}")
      assert has_element?(view, "[data-role=all-not-started-qty]", "1")
      assert has_element?(view, "[data-role=all-received-qty]", "0")

      Orders.update_order_status(order.id, "RECEIVED", "NOT_STARTED")

      send(view.pid, {:order_udpated, %{status: :RECEIVED}, "NOT_STARTED"})

      refute has_element?(view, "[data-role=order-status][data-id=NOT_STARTED#{order.id}")
      assert has_element?(view, "[data-role=order-status][data-id=RECEIVED#{order.id}")
      assert has_element?(view, "[data-role=all-not-started-qty]", "0")
      assert has_element?(view, "[data-role=all-received-qty]", "1")
    end
  end
end
