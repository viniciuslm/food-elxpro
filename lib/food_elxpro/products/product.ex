defmodule FoodElxpro.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w/description/a
  @required_fields ~w/name price size/a

  @primary_key {:id, :binary_id, autogenerete: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :name, :string
    field :price, :integer
    field :size, :string
    field :description, :string

    timestamps()
  end

  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)

  def changeset(product, attrs) do
    product
    |> cast(attrs, @fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end
end
