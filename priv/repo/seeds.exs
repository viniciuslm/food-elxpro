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

{:ok, product} =
  %{
    name: Faker.Food.dish(),
    description: Faker.Food.description(),
    price: :random.uniform(10_000),
    size: "small",
    product_url: %Plug.Upload{
      content_type: "image/png",
      filename: "logo.png",
      path: "priv/static/images/logo.png"
    }
  }
  |> Products.create_product()
