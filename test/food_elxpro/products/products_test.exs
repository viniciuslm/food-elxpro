defmodule FoodElxpro.ProductsTest do
  use FoodElxpro.DataCase
  alias FoodElxpro.Products
  alias FoodElxpro.Products.Product

  test "list_products/0" do
    assert Products.list_products() == []
  end

  test "delete_product/1" do
    payload = %{name: "pizza", size: "small", price: 100, description: "calabresa"}
    {:ok, %Product{} = product} = Products.create_product(payload)

    assert {:ok, %Product{}} = Products.delete_product(product.id)
    assert_raise Ecto.NoResultsError, fn -> Products.get!(product.id) end
  end

  test "get!/1" do
    payload = %{name: "pizza", size: "small", price: 100, description: "calabresa"}
    {:ok, %Product{} = product} = Products.create_product(payload)
    product_get = Products.get!(product.id)

    assert product.description == product_get.description
    assert product.name == product_get.name
    assert product.price == product_get.price
    assert "" == Products.get_image(product)
  end

  test "create_product" do
    file_upload = %Plug.Upload{
      content_type: "image/png",
      filename: "photo.png",
      path: "test/support/fixtures/photo.png"
    }

    payload = %{
      name: "pizza",
      size: "small",
      price: 100,
      description: "calabresa",
      product_url: file_upload
    }

    {:ok, %Product{} = product} = Products.create_product(payload)
    [url | _] = Products.get_image(product)

    assert String.contains?(url, file_upload.filename)
  end

  test "create product with image get the image url" do
    payload = %{name: "pizza", size: "small", price: 100, description: "calabresa"}

    {:ok, %Product{} = product} = Products.create_product(payload)

    assert product.description == payload.description
    assert product.name == payload.name
    assert product.price == %Money{amount: 100, currency: :BRL}
  end

  test "update_product" do
    payload = %{name: "pizza", size: "small", price: 100, description: "calabresa"}
    {:ok, %Product{} = product} = Products.create_product(payload)
    payload_update = %{name: "pizza 2", size: "small 2", price: 120, description: "calabresa 2"}
    {:ok, %Product{} = product} = Products.update_product(product, payload_update)

    assert product.description == payload_update.description
    assert product.name == payload_update.name
    assert product.price == %Money{amount: 120, currency: :BRL}
  end

  test "given a product whith the same should throw an error message" do
    payload = %{name: "pizza", size: "small", price: 100, description: "calabresa"}

    {:ok, %Product{} = _product} = Products.create_product(payload)
    assert {:error, changeset} = Products.create_product(payload)
    assert "has already been taken" in errors_on(changeset).name
    assert %{name: ["has already been taken"]} = errors_on(changeset)
  end

  test "create product with image invalid type" do
    file_upload = %Plug.Upload{
      content_type: "image/svg",
      filename: "photo.svg",
      path: "test/support/fixtures/photo.svg"
    }

    payload = %{
      name: "pizza",
      size: "small",
      price: 100,
      description: "calabresa",
      product_url: file_upload
    }

    assert {:error, changeset} = Products.create_product(payload)
    assert "file type is invalid" in errors_on(changeset).product_url
    assert %{product_url: ["file type is invalid"]} = errors_on(changeset)
  end
end
