defmodule FoodElxproWeb.Customer.OrderLive.StatusTest do
  use FoodElxproWeb.ConnCase
  import FoodElxpro.Factory
  import Phoenix.HTML.Form, only: [humanize: 1]
  import Phoenix.LiveViewTest
  alias FoodElxpro.Orders

  describe "test is status is loaded" do
    setup :register_and_log_in_user

    test "render when there has orders", %{conn: conn, user: user} do
      order = insert(:order, user: user)
      {:ok, view, _html} = live(conn, Routes.customer_order_status_path(conn, :status, order))
      assert has_element?(view, "[data-id=order-list]", "< back")
      assert has_element?(view, "[data-role=title-screen]", "Track delivered status")
      assert has_element?(view, "[data-role=order-id]", order.id)

      Orders.get_status_list()
      |> Enum.each(fn {status, _index} ->
        assert has_element?(
                 view,
                 "[data-role=order-status][data-id=#{Atom.to_string(status)}]",
                 humanize(status)
               )
      end)
    end

    test "back to order list", %{conn: conn, user: user} do
      order = insert(:order, user: user)
      {:ok, view, _html} = live(conn, Routes.customer_order_status_path(conn, :status, order))

      {:ok, _view, html} =
        view
        |> element("[data-id=order-list")
        |> render_click()
        |> follow_redirect(conn, Routes.customer_order_path(conn, :index))

      assert html =~ "All Orders"
    end

    test "update order status", %{conn: conn, user: user} do
      order = insert(:order, user: user)
      {:ok, view, _html} = live(conn, Routes.customer_order_status_path(conn, :status, order))

      assert view |> element("[data-role=status-item][data-id=NOT_STARTED]") |> render =~
               "current"

      {:ok, order} = Orders.update_order_status(order.id, "RECEIVED", "NOT_STARTED")

      send(view.pid, {:update_order, order})

      assert view |> element("[data-role=status-item][data-id=NOT_STARTED]") |> render =~
               "step-completed"

      assert view |> element("[data-role=status-item][data-id=RECEIVED]") |> render =~
               "current"
    end
  end
end
