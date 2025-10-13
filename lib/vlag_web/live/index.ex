defmodule VlagWeb.Live.Index do
  use Phoenix.LiveView

  def mount(%{"date" => date}, _, socket) do
    start_timer(1)

    date = Date.from_iso8601!(date)

    {:ok,
     socket
     |> assign(:date, date)
     |> assign_flag_values()}
  end

  def mount(_params, _, socket) do
    start_timer(1)

    {:ok,
     socket
     |> assign_flag_values()}
  end

  defp assign_flag_values(socket) do
    now =
      Vlag.Now.get()
      |> dynamic_time(socket)

    socket
    |> assign(:now, now |> DateTime.to_time() |> Time.truncate(:second) |> Time.to_string())
    |> assign(:daytime, Vlag.Sun.up?(now))
    |> assign(:wreath, Vlag.Elements.wreath?(now))
    |> assign(:raised, Vlag.Elements.flag_raised?(now))
    |> assign(:half_raised, Vlag.Elements.flag_half_raised?(now))
    |> assign(:pennon, Vlag.Elements.pennon?(now))
    |> assign(:description, Vlag.Elements.description(now))
  end

  defp dynamic_time(_now, %{assigns: %{date: date}}), do: DateTime.new!(date, ~T[12:00:00])
  defp dynamic_time(now, _socket), do: now

  def handle_info(:clock_tick, socket) do
    {:noreply,
     socket
     |> assign_flag_values()}
  end

  defp start_timer(interval_in_seconds) do
    :timer.send_interval(interval_in_seconds * 1000, :clock_tick)
  end
end
