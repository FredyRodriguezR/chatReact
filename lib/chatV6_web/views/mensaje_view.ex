defmodule ChatV6Web.MensajeView do
  use ChatV6Web, :view
  alias ChatV6Web.MensajeView

  def render("index.json", %{mensajes: mensajes}) do
    %{data: render_many(mensajes, MensajeView, "mensaje.json")}
  end

  def render("show.json", %{mensaje: mensaje}) do
    %{data: render_one(mensaje, MensajeView, "mensaje.json")}
  end

  def render("mensaje.json", %{mensaje: mensaje}) do
    %{id: mensaje.id,
      name: mensaje.name,
      body: mensaje.body}
  end
end
