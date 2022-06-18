defmodule FoodElxproWeb.CartLive.EmptyCartTest do
  use FoodElxproWeb.ConnCase
  import Phoenix.LiveViewTest
  alias FoodElxproWeb.Router.Helpers, as: Routes

  test "when you enter cart and have empty cart", %{conn: conn} do
    {:ok, view, html} = live(conn, Routes.cart_path(conn, :index))

    assert html =~ "Your cart is empty!!!"
    assert render(view) =~ "Your cart is empty!!!"

    assert has_element?(view, "[data-role=go-main-page]", "Go back")
  end
end
