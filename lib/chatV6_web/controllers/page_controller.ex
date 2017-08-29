defmodule ChatV6Web.PageController do
  use ChatV6Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
