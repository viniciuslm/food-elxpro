defmodule FoodElxpro.Factory do
  use ExMachina.Ecto, repo: FoodElxpro.Repo
  alias FoodElxpro.Products.Product

  def product_factory do
    %Product{
      description: Faker.Food.description(),
      name: Faker.Food.dish(),
      price: :rand.uniform(10_000),
      size: "small"
    }
  end
end
