defmodule FoodElxpro.Products do
  alias FoodElxpro.Products.Product
  alias FoodElxpro.Repo

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

  def change_product, do: Product.changeset()

  def change_product(product, attrs \\ %{}), do: Product.changeset(product, attrs)
end
