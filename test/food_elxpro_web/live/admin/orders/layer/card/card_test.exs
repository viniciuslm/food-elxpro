defmodule FoodElxproWeb.Admin.OrderLive.Layer.CardTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodElxpro.Factory

  describe "test is card loaded" do
    setup :register_and_log_in_user_admin

    test "render main elements", %{conn: conn} do
      order = insert(:order)
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))

      assert has_element?(view, "##{order.id}")
      assert has_element?(view, "[data-role=card-number][data-id=#{order.id}", order.id)
      assert has_element?(view, "[data-role=list-items-title][data-id=#{order.id}", "Order Items")

      Enum.each(order.items, fn item ->
        assert has_element?(view, "[data-role=item][data-id=#{order.id}#{item.id}")

        assert has_element?(
                 view,
                 "[data-role=item-description][data-id=#{order.id}#{item.id}",
                 Integer.to_string(item.quantity)
               )
      end)

      assert has_element?(
               view,
               "[data-role=list-description-title][data-id=#{order.id}",
               "Order Description"
             )

      assert has_element?(
               view,
               "[data-role=total-price-amount][data-id=#{order.id}",
               Money.to_string(order.total_price)
             )

      assert has_element?(
               view,
               "[data-role=total-quantity-amount][data-id=#{order.id}",
               Integer.to_string(order.total_quantity)
             )
    end
  end
end
