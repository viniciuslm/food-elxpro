defmodule FoodElxproWeb.Admin.OrderLive.Layer do
  use FoodElxproWeb, :live_component
  alias __MODULE__.Card

  @status [:NOT_STARTED, :DELIVERED]

  def update(assigns, socket) do
    cards = [
      %{
        id: Ecto.UUID.generate(),
        user: %{
          email: "viniciuslm@gmail.com"
        },
        status: @status |> Enum.shuffle() |> hd,
        updated_at: DateTime.utc_now(),
        total_price: Money.new(1_000),
        total_quantity: 2,
        items: [
          %{
            id: Ecto.UUID.generate(),
            quantity: 1,
            product: %{
              name: "abobora",
              price: Money.new(200)
            }
          },
          %{
            id: Ecto.UUID.generate(),
            quantity: 1,
            product: %{
              name: "banana",
              price: Money.new(100)
            }
          }
        ]
      },
      %{
        id: Ecto.UUID.generate(),
        user: %{
          email: "viniciuslm@gmail.com"
        },
        status: @status |> Enum.shuffle() |> hd,
        updated_at: DateTime.utc_now(),
        total_price: Money.new(1_000),
        total_quantity: 2,
        items: [
          %{
            id: Ecto.UUID.generate(),
            quantity: 1,
            product: %{
              name: "abobora",
              price: Money.new(200)
            }
          },
          %{
            id: Ecto.UUID.generate(),
            quantity: 1,
            product: %{
              name: "banana",
              price: Money.new(100)
            }
          }
        ]
      }
    ]

    {:ok, socket |> assign(assigns) |> assign(cards: cards)}
  end
end
