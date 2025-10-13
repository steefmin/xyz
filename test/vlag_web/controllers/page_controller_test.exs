defmodule SteefMinWeb.PageControllerTest do
  alias Vlag.Flagday.Birth.Amalia
  alias Vlag.Flagday.Birth.Beatrix
  alias Vlag.Flagday.Birth.Maxima
  alias Vlag.Flagday.EndOfWW2
  alias Vlag.Flagday.KingdomDay
  alias Vlag.Flagday.Kingsday
  alias Vlag.Flagday.LiberationDay
  alias Vlag.Flagday.PrinceDay
  alias Vlag.Flagday.RemembranceDay
  alias Vlag.Flagday.VeteransDay
  use SteefMinWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: Map.put(conn, :host, "vlag.steefmin.xyz")}
  end

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Online vlaggenmast"
  end

  test "GET birth of amalia", %{conn: conn} do
    conn = get(conn, "/simulate/2025-12-08")
    assert html_response(conn, 200) =~ Amalia.get_text()
  end

  test "GET birth of beatrix", %{conn: conn} do
    conn = get(conn, "/simulate/2025-01-31")
    assert html_response(conn, 200) =~ Beatrix.get_text()
  end

  test "GET birth of maxima", %{conn: conn} do
    conn = get(conn, "/simulate/2025-05-17")
    assert html_response(conn, 200) =~ Maxima.get_text()
  end

  test "GET end of WW2", %{conn: conn} do
    conn = get(conn, "/simulate/2025-08-15")
    assert html_response(conn, 200) =~ EndOfWW2.get_text()
  end

  test "GET kingdom day", %{conn: conn} do
    conn = get(conn, "/simulate/2025-12-15")
    assert html_response(conn, 200) =~ KingdomDay.get_text()
  end

  test "GET kings day", %{conn: conn} do
    conn = get(conn, "/simulate/2025-04-26")
    assert html_response(conn, 200) =~ Kingsday.get_text()
  end

  test "GET liberation day", %{conn: conn} do
    conn = get(conn, "/simulate/2025-05-05")
    assert html_response(conn, 200) =~ LiberationDay.get_text()
  end

  test "GET prince day", %{conn: conn} do
    conn = get(conn, "/simulate/2025-09-16")
    assert html_response(conn, 200) =~ PrinceDay.get_text()
  end

  test "GET remembrance day", %{conn: conn} do
    conn = get(conn, "/simulate/2025-05-04")
    assert html_response(conn, 200) =~ RemembranceDay.get_text()
  end

  test "GET veterans day", %{conn: conn} do
    conn = get(conn, "/simulate/2025-06-28")
    assert html_response(conn, 200) =~ VeteransDay.get_text()
  end
end
