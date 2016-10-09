defmodule HelloPhoenix.PageView do
  use HelloPhoenix.Web, :view

  def csrf_token(conn) do
    Plug.Conn.get_session(conn, :csrf_token)
  end
end
