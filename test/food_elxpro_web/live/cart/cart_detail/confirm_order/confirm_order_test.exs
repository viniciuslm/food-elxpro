defmodule FoodElxproWeb.CartLive.CartDetail.ConfirmOrderTest do
  use FoodElxproWeb.ConnCase
  import FoodElxpro.Factory
  import Phoenix.LiveViewTest

  # test "create order with non user authenticated", %{conn: conn} do
  #   product = insert(:product)
  #   main_route = Routes.main_path(conn, :index)
  #   {:ok, view, _html} = live(conn, main_route)
  #   product_element = build_product_element(product.id)

  #   view
  #   |> add_product(product_element, conn)

  #   cart_route = Routes.cart_path(conn, :index)
  #   {:ok, view, _html} = live(conn, cart_route)

  #   assert false == true
  # end

  describe "user authenticated" do
    setup :register_and_log_in_user

    test "should create an order", %{conn: conn} do
      product = insert(:product)
      main_route = Routes.main_path(conn, :index)
      {:ok, view, _html} = live(conn, main_route)
      product_element = build_product_element(product.id)

      view
      |> add_product(product_element, conn)

      cart_route = Routes.cart_path(conn, :index)
      {:ok, view, _html} = live(conn, cart_route)

      {:ok, _view, html} =
        view
        |> form("#confirm-order-form", %{
          "phone_number" => "123456",
          "address" => "Rua teste, 15"
        })
        |> render_submit()
        |> follow_redirect(conn, Routes.customer_order_path(conn, :index))

      assert html =~ "Order create with sucess"
    end

    test "error to create order", %{conn: conn} do
      product = insert(:product)
      main_route = Routes.main_path(conn, :index)
      {:ok, view, _html} = live(conn, main_route)
      product_element = build_product_element(product.id)

      view
      |> add_product(product_element, conn)

      cart_route = Routes.cart_path(conn, :index)
      {:ok, view, _html} = live(conn, cart_route)

      {:ok, _view, html} =
        view
        |> form("#confirm-order-form", %{})
        |> render_submit()
        |> follow_redirect(conn, Routes.cart_path(conn, :index))

      assert html =~ "Something went wrong, please verify your order"
    end
  end

  defp build_product_element(product_id),
    do: "[data-role=product-add][data-id=item-#{product_id}]"

  defp add_product(view, product_element, conn) do
    {:ok, view, _html} =
      view
      |> element(product_element)
      |> render_click()
      |> follow_redirect(conn, Routes.main_path(conn, :index))

    view
  end
end
