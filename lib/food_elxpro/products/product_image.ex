defmodule FoodElxpro.Products.ProductImage do
  import Waffle

  use Waffle.Definition
  use Waffle.Ecto.Definition

  @extension_whitelist ~w(.png .jpg .jpeg)

  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname |> String.downcase

    case Enum.member?(@extension_whitelist, file_extension) do
      true -> :ok
      false -> {:error, "file type is invalid"}
    end
  end

  def storage_dir(file_type, {file, product}) do
    "/upload/products/#{product.id}"
  end
end
