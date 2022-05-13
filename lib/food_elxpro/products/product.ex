defmodule FoodElxpro.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias FoodElxpro.Products.ProductImage
  import Waffle.Ecto.Schema

  @fields ~w/description/a
  @required_fields ~w/name price size/a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :name, :string
    field :price, Money.Ecto.Amount.Type
    field :size, :string
    field :description, :string
    field :product_url, ProductImage.Type

    timestamps()
  end

  def changeset(attrs \\ %{}), do: changeset(%__MODULE__{}, attrs)

  def changeset(product, attrs) do
    product
    |> cast(attrs, @fields ++ @required_fields)
    |> cast_attachments(attrs, [:product_url])
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end
end
