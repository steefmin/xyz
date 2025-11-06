defmodule SteefMinWeb.Live.Home do
  use SteefMinWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Welcome</h1>
    """
  end
end
