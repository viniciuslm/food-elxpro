alias FoodElxpro.{Accounts, Products}

Accounts.register_user(%{
  email: "viniciuslm@gmail.com",
  password: "Vlm@123",
  role: "ADMIN"
})

Accounts.register_user(%{
  email: "vlm@gmail.com",
  password: "Vlm@123",
  role: "USER"
})

Enum.each(1..200, fn _ ->
  image = :rand.uniform(4)

  %{
    name: Faker.Food.dish(),
    description: Faker.Food.description(),
    price: :random.uniform(10_000),
    size: "small",
    product_url: %Plug.Upload{
      content_type: "image/jpg",
      filename: "product_#{image}.jpg",
      path: "priv/static/images/product_#{image}.jpg"
    }
  }
  |> Products.create_product()
end)
