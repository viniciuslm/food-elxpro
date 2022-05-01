alias FoodElxpro.Accounts

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
