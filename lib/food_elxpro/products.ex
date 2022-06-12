defmodule FoodElxpro.Products do
  alias FoodElxpro.Products.{Product, ProductImage}
  alias FoodElxpro.Repo

  import Ecto.Query

  def list_products(name) do
    name = "%" <> name <> "%"

    Product
    |> where([p], ilike(p.name, ^name))
    |> Repo.all()
  end

  def list_products, do: Repo.all(Product)

  def get!(id), do: Repo.get!(Product, id)

  def create_product(attrs \\ %{}) do
    attrs
    |> Product.changeset()
    |> Repo.insert()
  end

  def update_product(product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_product(id) do
    id
    |> get!()
    |> Repo.delete()
  end

  def change_product(product, attrs \\ %{}), do: Product.changeset(product, attrs)

  def get_image(product) do
    {product.product_url, product}
    |> ProductImage.url(:final, signed: true)
    |> get_image_url
  end

  defp get_image_url(nil), do: ""

  defp get_image_url(url) do
    if Mix.env() == :prod do
      url
    else
      [_ | url] = String.split(url, "/priv/static")
      url
    end
  end
end
