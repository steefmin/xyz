defmodule SteefMinWeb.Controller.HealthController do
  use SteefMinWeb, :controller

  def index(conn, _params) do
    send_resp(conn, 200, "OK")
  end
end
