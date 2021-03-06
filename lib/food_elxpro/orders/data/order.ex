defmodule FoodElxpro.Orders.Data.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias FoodElxpro.Accounts.User
  alias FoodElxpro.Orders.Data.Item

  @status_value [:NOT_STARTED, :RECEIVED, :PREPARING, :DELIVERING, :DELIVERED]
  @field [:status]
  @required_field [:total_price, :total_quantity, :user_id, :address, :phone_number]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :total_quantity, :integer
    field :address, :string
    field :phone_number, :string
    field :total_price, Money.Ecto.Amount.Type
    field :status, Ecto.Enum, values: @status_value, default: :NOT_STARTED

    belongs_to :user, User
    has_many :items, Item

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, @field ++ @required_field)
    |> validate_required(@required_field)
    |> validate_number(:total_quantity, greater_than: 0)
    |> cast_assoc(:items, with: &Item.changeset/2)
  end
end
