defmodule ChatV6.ComunicacionTest do
  use ChatV6.DataCase

  alias ChatV6.Comunicacion

  describe "mensajes" do
    alias ChatV6.Comunicacion.Mensaje

    @valid_attrs %{body: "some body", name: "some name"}
    @update_attrs %{body: "some updated body", name: "some updated name"}
    @invalid_attrs %{body: nil, name: nil}

    def mensaje_fixture(attrs \\ %{}) do
      {:ok, mensaje} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Comunicacion.create_mensaje()

      mensaje
    end

    test "list_mensajes/0 returns all mensajes" do
      mensaje = mensaje_fixture()
      assert Comunicacion.list_mensajes() == [mensaje]
    end

    test "get_mensaje!/1 returns the mensaje with given id" do
      mensaje = mensaje_fixture()
      assert Comunicacion.get_mensaje!(mensaje.id) == mensaje
    end

    test "create_mensaje/1 with valid data creates a mensaje" do
      assert {:ok, %Mensaje{} = mensaje} = Comunicacion.create_mensaje(@valid_attrs)
      assert mensaje.body == "some body"
      assert mensaje.name == "some name"
    end

    test "create_mensaje/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comunicacion.create_mensaje(@invalid_attrs)
    end

    test "update_mensaje/2 with valid data updates the mensaje" do
      mensaje = mensaje_fixture()
      assert {:ok, mensaje} = Comunicacion.update_mensaje(mensaje, @update_attrs)
      assert %Mensaje{} = mensaje
      assert mensaje.body == "some updated body"
      assert mensaje.name == "some updated name"
    end

    test "update_mensaje/2 with invalid data returns error changeset" do
      mensaje = mensaje_fixture()
      assert {:error, %Ecto.Changeset{}} = Comunicacion.update_mensaje(mensaje, @invalid_attrs)
      assert mensaje == Comunicacion.get_mensaje!(mensaje.id)
    end

    test "delete_mensaje/1 deletes the mensaje" do
      mensaje = mensaje_fixture()
      assert {:ok, %Mensaje{}} = Comunicacion.delete_mensaje(mensaje)
      assert_raise Ecto.NoResultsError, fn -> Comunicacion.get_mensaje!(mensaje.id) end
    end

    test "change_mensaje/1 returns a mensaje changeset" do
      mensaje = mensaje_fixture()
      assert %Ecto.Changeset{} = Comunicacion.change_mensaje(mensaje)
    end
  end
end
