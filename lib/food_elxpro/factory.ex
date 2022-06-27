defmodule FoodElxpro.Factory do
  use ExMachina.Ecto, repo: FoodElxpro.Repo
  alias FoodElxpro.Accounts.User
  alias FoodElxpro.Orders.Data.Order
  alias FoodElxpro.Products.Product
  alias FoodElxpro.Repo
  @size ~w/small medium large/s

  def product_factory do
    %Product{
      description: Faker.Food.description(),
      name: Faker.Food.dish() <> (:rand.uniform(100) |> Integer.to_string()),
      price: :rand.uniform(10_000),
      size: @size |> Enum.shuffle() |> hd
    }
  end

  def order_factory(attrs) do
    user =
      if attrs[:user] do
        attrs[:user]
      else
        %User{}
        |> User.registration_changeset(%{
          email: "test-#{:rand.uniform(10_000)}@vlm.com",
          password: "Vlm@123"
        })
        |> Repo.insert!()
      end

    product_1 = insert(:product)
    product_2 = insert(:product)

    total_price = product_1.price |> Money.multiply(2) |> Money.add(product_2.price)

    %Order{
      user_id: user.id,
      address: Faker.Address.PtBr.street_address(),
      phone_number: Faker.Phone.PtBr.phone(),
      items: [
        %{
          quantity: 2,
          product_id: product_1.id
        },
        %{
          quantity: 1,
          product_id: product_2.id
        }
      ],
      total_quantity: 3,
      total_price: total_price
    }
  end
end
