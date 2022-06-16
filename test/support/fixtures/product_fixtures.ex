defmodule FoodElxpro.ProductFixtures do
  alias FoodElxpro.Products

  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: Faker.Food.description(),
        name: Faker.Food.dish(),
        price: :rand.uniform(10_000),
        size: "small"
      })
      |> Products.create_product()

    product
  end
end
