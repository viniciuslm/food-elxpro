defmodule FoodElxproWeb.Admin.OrderLive.Layer.CardTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "test is card loaded" do
    setup :register_and_log_in_user_admin

    test "render main elements", %{conn: conn} do
      card = %{id: "123"}
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))
      assert has_element?(view, "[data-role=card-NOT_STARTED][data-id=#{card.id}]")
    end
  end
end
