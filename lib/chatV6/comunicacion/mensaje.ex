defmodule ChatV6.Comunicacion.Mensaje do
  use Ecto.Schema
  import Ecto.Changeset
  alias ChatV6.Comunicacion.Mensaje


  schema "mensajes" do
    field :body, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Mensaje{} = mensaje, attrs) do
    mensaje
    |> cast(attrs, [:name, :body])
    |> validate_required([:name, :body])
  end
end
