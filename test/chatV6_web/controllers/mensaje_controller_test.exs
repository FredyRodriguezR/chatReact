defmodule ChatV6Web.MensajeControllerTest do
  use ChatV6Web.ConnCase

  alias ChatV6.Comunicacion
  alias ChatV6.Comunicacion.Mensaje

  @create_attrs %{body: "some body", name: "some name"}
  @update_attrs %{body: "some updated body", name: "some updated name"}
  @invalid_attrs %{body: nil, name: nil}

  def fixture(:mensaje) do
    {:ok, mensaje} = Comunicacion.create_mensaje(@create_attrs)
    mensaje
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all mensajes", %{conn: conn} do
      conn = get conn, mensaje_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create mensaje" do
    test "renders mensaje when data is valid", %{conn: conn} do
      conn = post conn, mensaje_path(conn, :create), mensaje: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, mensaje_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some body",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, mensaje_path(conn, :create), mensaje: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update mensaje" do
    setup [:create_mensaje]

    test "renders mensaje when data is valid", %{conn: conn, mensaje: %Mensaje{id: id} = mensaje} do
      conn = put conn, mensaje_path(conn, :update, mensaje), mensaje: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, mensaje_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some updated body",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, mensaje: mensaje} do
      conn = put conn, mensaje_path(conn, :update, mensaje), mensaje: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete mensaje" do
    setup [:create_mensaje]

    test "deletes chosen mensaje", %{conn: conn, mensaje: mensaje} do
      conn = delete conn, mensaje_path(conn, :delete, mensaje)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, mensaje_path(conn, :show, mensaje)
      end
    end
  end

  defp create_mensaje(_) do
    mensaje = fixture(:mensaje)
    {:ok, mensaje: mensaje}
  end
end
