defmodule FoodElxproWeb.Customer.OrderLiveTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodElxpro.Factory
  import Phoenix.Naming

  describe "test is order loaded" do
    setup :register_and_log_in_user_admin

    test "render when there is no orders", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.customer_order_path(conn, :index))

      assert has_element?(view, "[data-role=section-title]", "All Orders")
      assert has_element?(view, "[data-role=no-orders]", "No orders founds")
    end

    test "render when there has orders", %{conn: conn, user: user} do
      order = insert(:order, user: user)

      {:ok, view, _html} = live(conn, Routes.customer_order_path(conn, :index))

      assert has_element?(view, "##{order.id}")
      assert has_element?(view, "[data-role=show-status][data-id=#{order.id}]", order.id)
      assert has_element?(view, "[data-role=details][data-id=#{order.id}]", order.address)
      assert has_element?(view, "[data-role=details][data-id=#{order.id}]", order.phone_number)

      assert has_element?(
               view,
               "[data-role=status][data-id=#{order.id}]",
               humanize(order.status)
             )

      assert has_element?(
               view,
               "[data-role=date][data-id=#{order.id}]",
               order.updated_at |> NaiveDateTime.to_string()
             )
    end
  end
end
