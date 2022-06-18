defmodule LiveSessions.PermissionsTest do
  use FoodElxproWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "when is admin" do
    setup :register_and_log_in_user_admin

    test "load page", %{conn: conn} do
      {:ok, _view, _html} = live(conn, Routes.admin_product_path(conn, :index))
    end
  end

  describe "when is not admin" do
    setup :register_and_log_in_user

    test "load page, show access denied", %{conn: conn} do
      {:error, {:redirect, %{flash: message, to: "/"}}} =
        live(conn, Routes.admin_product_path(conn, :index))

      assert message == %{"error" => "You don't have permissions to access this page"}
    end
  end

  describe "when is not logged int" do
    test "load page, show access denied", %{conn: conn} do
      {:error, {:redirect, %{flash: message, to: "/users/log_in"}}} =
        live(conn, Routes.admin_product_path(conn, :index))

      assert message == %{"error" => "You must log in to access this page."}
    end
  end
end
