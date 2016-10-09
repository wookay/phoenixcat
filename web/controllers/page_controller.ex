defmodule HelloPhoenix.PageController do
  require IEx
  use HelloPhoenix.Web, :controller

  def index(conn, _params) do
#IEx.pry
    render conn, "index.html"
  end

  def create(conn, _params) do
    render conn, "create.html"
  end
end
