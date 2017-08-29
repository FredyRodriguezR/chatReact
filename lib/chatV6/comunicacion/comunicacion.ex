defmodule ChatV6.Comunicacion do
  @moduledoc """
  The Comunicacion context.
  """

  import Ecto.Query, warn: false
  alias ChatV6.Repo

  alias ChatV6.Comunicacion.Mensaje

  @doc """
  Returns the list of mensajes.

  ## Examples

      iex> list_mensajes()
      [%Mensaje{}, ...]

  """
  def list_mensajes do
    Repo.all(Mensaje)
  end

  @doc """
  Gets a single mensaje.

  Raises `Ecto.NoResultsError` if the Mensaje does not exist.

  ## Examples

      iex> get_mensaje!(123)
      %Mensaje{}

      iex> get_mensaje!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mensaje!(id), do: Repo.get!(Mensaje, id)

  @doc """
  Creates a mensaje.

  ## Examples

      iex> create_mensaje(%{field: value})
      {:ok, %Mensaje{}}

      iex> create_mensaje(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mensaje(attrs \\ %{}) do
    %Mensaje{}
    |> Mensaje.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mensaje.

  ## Examples

      iex> update_mensaje(mensaje, %{field: new_value})
      {:ok, %Mensaje{}}

      iex> update_mensaje(mensaje, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mensaje(%Mensaje{} = mensaje, attrs) do
    mensaje
    |> Mensaje.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Mensaje.

  ## Examples

      iex> delete_mensaje(mensaje)
      {:ok, %Mensaje{}}

      iex> delete_mensaje(mensaje)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mensaje(%Mensaje{} = mensaje) do
    Repo.delete(mensaje)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mensaje changes.

  ## Examples

      iex> change_mensaje(mensaje)
      %Ecto.Changeset{source: %Mensaje{}}

  """
  def change_mensaje(%Mensaje{} = mensaje) do
    Mensaje.changeset(mensaje, %{})
  end
end
