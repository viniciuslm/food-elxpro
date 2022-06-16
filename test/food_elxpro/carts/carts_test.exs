defmodule FoodElxpro.CartsTest do
  use FoodElxpro.DataCase
  alias FoodElxpro.Carts

  test "should create session" do
    assert :ok == Carts.create_session(4444)
  end
end
