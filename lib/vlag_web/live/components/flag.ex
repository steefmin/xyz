defmodule VlagWeb.Live.Flag do
  use Phoenix.LiveComponent

  defp default_parts do
    [
      "#AE1C28",
      "#FFFFFF",
      "#21468B"
    ]
  end

  defp flag_height(parts, part_height) do
    Enum.count(parts) * part_height
  end

  defp flag_width(parts, part_height, aspect_ratio) do
    flag_height(parts, part_height) / aspect_ratio
  end

  defp clip_width(parts, part_height, aspect_ratio) do
    flag_width(parts, part_height, aspect_ratio)
  end

  defp clip_height(parts, part_height, wave_height) do
    flag_height(parts, part_height) + 2 * wave_height
  end

  def mount(socket) do
    {
      :ok,
      socket
      |> assign(:show, false)
      |> assign(:id, "flag")
      |> assign(:height, 0)
      |> assign(:parts, default_parts())
      |> assign(:part_height, 20)
      |> assign(:aspect_ratio, 0.666)
      |> assign(:wave_height, 20)
    }
  end

  defp animation_style(wave_height) do
    "--waveheight-translation: translateY(#{wave_height}px); --animation-duration: 5000ms"
  end

  defp clip_path_style(id) do
    "clip-path: url(##{clip_path_id(id)})"
  end

  defp clip_path_id(id) do
    "clipPathId-#{id}"
  end

  defp height_style(height) do
    "transform: translate(352px, #{132 + height}px)"
  end

  defp x_animation_style(id) do
    "animation-name: move-x-#{id}; animation-timing-function: linear;"
  end

  defp y_animation_style(id) do
    "animation-name: move-y-#{id}; animation-timing-function: ease-in-out;"
  end

  defp class_for_id(class, id) do
    "#{class}-#{id}"
  end

  defp css_class_for_id(class, id) do
    class_name = class_for_id(class, id)
    ".#{class_name}"
  end

  def render(assigns) do
    ~H"""
    <g id={@id} class={class_for_id("flagElement", @id)} style={height_style(@height)}>
      <%= if @show do %>
        <defs>
          <clipPath id={clip_path_id(@id)}>
            <rect
              x="0"
              y="0"
              width={clip_width(@parts, @part_height, @aspect_ratio)}
              height={clip_height(@parts, @part_height, @wave_height)}
            />
          </clipPath>
        </defs>

        <g class="flag" style={clip_path_style(@id)}>
          <g style={animation_style(@wave_height)}>
            <g class={class_for_id("animated", @id)} stroke="none" style={y_animation_style(@id)}>
              <g class={class_for_id("animated", @id)} style={x_animation_style(@id)}>
                <%= for {color, index} <- Enum.with_index(@parts) do %>
                  <path
                    class="animated part"
                    d={VlagWeb.Live.Flag.Part.create(index, @part_height, @wave_height)}
                    fill={color}
                  />
                <% end %>
              </g>
            </g>
          </g>
        </g>
        <style>
          <%= css_class_for_id("flagElement", @id) %> {
              /* sane defaults, overwrite in component properties */
              --animation-duration: 5000ms;
              --waveheight-translation: 200px;
          }

          <%= css_class_for_id("animated", @id) %> {
              animation-direction: normal;
              animation-duration: var(--animation-duration);
              animation-iteration-count: infinite;
              animation-delay: 0s;
              animation-fill-mode: forwards;
          }

          @keyframes move-x-<%= @id %> {
              from {
                  transform: translateX(-200px); /* one waveLength = 200px */
              }
              to {
                  transform: translateX(0px);
              }
          }

          @keyframes move-y-<%= @id %> {
              from, to {
                  transform: translateY(0px);
              }
              50% {
                  transform: translateY(-<%= @part_height %>px); /* one waveHeight */
              }
          }
        </style>
      <% end %>
    </g>
    """
  end
end
