defmodule VlagWeb.Live.Background do
  use Phoenix.LiveComponent

  def mount(socket) do
    socket =
      socket
      |> assign(:shadow_color, "#64A02B")
      |> assign(:shadow_width, 10)
      |> assign(:pole_color, "#ffffff")
      |> assign(:pole_width, 10)
      |> assign(:pole_x, 350)
      |> assign(:pole_shadow_color, "#afafaf")

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <g id="background">
      <g id="pole-group">
        <rect
          id="sky"
          width="700"
          height="700"
          fill={sky_color(@daytime)}
        />
        <rect
          id="ground"
          y="450"
          width="700"
          height="250"
          fill={ground_color(@daytime)}
        />
        <line
          id="groundShadow"
          x1={@pole_x}
          y1="495"
          x2="700"
          y2="495"
          stroke={@shadow_color}
          stroke-width={@shadow_width}
        />
        <line
          id="pole"
          x1={@pole_x}
          y1="150"
          x2={@pole_x}
          y2="500"
          stroke={@pole_color}
          stroke-width={@pole_width}
        />
        <line
          id="poleShadow"
          x1={pole_shadow_x(@pole_x, @pole_width)}
          y1="150"
          x2={pole_shadow_x(@pole_x, @pole_width)}
          y2="500"
          stroke={@pole_shadow_color}
          stroke-width={pole_shadow_stroke(@pole_width)}
        />
      </g>
    </g>
    """
  end

  defp pole_shadow_x(pole_x, pole_width) do
    pole_x + 3 * pole_width / 8
  end

  defp pole_shadow_stroke(pole_width) do
    pole_width / 4
  end

  defp sky_color(true = _daytime) do
    "#9af5f0"
  end

  defp sky_color(false = _daytime) do
    "#415870"
  end

  defp ground_color(true = _daytime) do
    "#96d65b"
  end

  defp ground_color(false = _daytime) do
    "#64A02B"
  end
end
