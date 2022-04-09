defmodule FoodElxpro.ProductsTest do
  use FoodElxpro.DataCase
  alias FoodElxpro.Products
  alias FoodElxpro.Products.Product

  test "list_products/0" do
    assert Products.list_products() == []
  end

  test "create_product" do
    payload = %{name: "pizza", size: "small", price: 100, description: "calabresa"}

    {:ok, %Product{} = product} = Products.create_product(payload)

    assert product.description == payload.description
    assert product.name == payload.name
    assert product.price == payload.price
  end

  test "given a product whith the same should throw an error message" do
    payload = %{name: "pizza", size: "small", price: 100, description: "calabresa"}

    {:ok, %Product{} = _product} = Products.create_product(payload)
    assert {:error, changeset} = Products.create_product(payload)
    assert "has already been taken" in errors_on(changeset).name
    assert %{name: ["has already been taken"]} = errors_on(changeset)
  end
end
