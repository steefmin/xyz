defmodule VlagWeb.Live.Pennon do
  use Phoenix.LiveComponent

  def mount(socket) do
    {
      :ok,
      socket
      |> assign(:show, false)
    }
  end

  defp parts do
    [
      "#fd7e14"
    ]
  end

  def render(assigns) do
    ~H"""
    <g>
      <.live_component
        module={VlagWeb.Live.Flag}
        id="pennon"
        parts={parts()}
        show={@show}
        z
        part_height={8}
        aspect_ratio={0.08}
        wave_height={8}
        height={11}
      />
    </g>
    """
  end
end
