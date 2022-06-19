defmodule FoodElxproWeb.Admin.OrderLive.LayerTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "test is layer loaded" do
    setup :register_and_log_in_user_admin

    test "render main elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_order_path(conn, :index))
      assert has_element?(view, "#NOT_STARTED")
      assert has_element?(view, "[data-role=layer-title][data-id=NOT_STARTED]", "Not started")

      # open_browser(view)
    end
  end
end
