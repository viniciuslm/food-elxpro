defmodule FoodElxpro.Products do
  alias FoodElxpro.Products.Product
  alias FoodElxpro.Repo

  def list_products, do: Repo.all(Product)

  def create_product(attrs \\ %{}) do
    attrs
    |> Product.changeset()
    |> Repo.insert()
  end

  def change_product, do: Product.changeset()
end
