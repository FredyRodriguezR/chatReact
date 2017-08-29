defmodule ChatV6Web.MensajeController do
  use ChatV6Web, :controller

  alias ChatV6.Comunicacion
  alias ChatV6.Comunicacion.Mensaje

  action_fallback ChatV6Web.FallbackController

  def index(conn, _params) do
    mensajes = Comunicacion.list_mensajes()
    render(conn, "index.json", mensajes: mensajes)
  end

  def create(conn, %{"mensaje" => mensaje_params}) do


    with {:ok, %Mensaje{} = mensaje} <- Comunicacion.create_mensaje(mensaje_params) do
      IO.puts("Entro")
      conn
      |> put_status(:created)
      |> put_resp_header("/mensajes", mensaje_path(conn, :show, mensaje))
      |> render("show.json", mensaje: mensaje)
    end

  end

  def show(conn, %{"id" => id}) do
    mensaje = Comunicacion.get_mensaje!(id)
    render(conn, "show.json", mensaje: mensaje)
  end

  def update(conn, %{"id" => id, "mensaje" => mensaje_params}) do
    mensaje = Comunicacion.get_mensaje!(id)

    with {:ok, %Mensaje{} = mensaje} <- Comunicacion.update_mensaje(mensaje, mensaje_params) do
      render(conn, "show.json", mensaje: mensaje)
    end
  end

  def delete(conn, %{"id" => id}) do
    mensaje = Comunicacion.get_mensaje!(id)
    with {:ok, %Mensaje{}} <- Comunicacion.delete_mensaje(mensaje) do
      send_resp(conn, :no_content, "")
    end
  end
end
