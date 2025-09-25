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

  def render(assigns) do
    ~H"""
    <header>
      <h1>Online vlaggenmast</h1>
    </header>
    <div class="container-row">
        <div class="container-column">
            <span class="container-row time">
                <h6> <%= @now %> </h6>
            </span>

            <svg
                class="container-row figure"
                viewBox="0 0 700 700"
                xmlns="http://www.w3.org/2000/svg"
            >
                <.live_component module={VlagWeb.Live.Background} id={"background"} daytime={ @daytime } />

                <.live_component module={VlagWeb.Live.Bushes} id={"bushes"} />

                <.live_component module={VlagWeb.Live.Wreath} id={"wreath"} show={ @wreath } />

                <.live_component module={VlagWeb.Live.Flag} id={"raised_flag"} show={ @raised } />

                <.live_component module={VlagWeb.Live.Flag} id={"half_raised_flag"} show={ @half_raised } height={ 100 } />

                <.live_component module={VlagWeb.Live.Pennon} id={"pennon_container"} show={ @pennon } />

            </svg>

            <span class="container-row data">
                <h6> <%= @description %> </h6>
            </span>
        </div>
    </div>
    <style>
    .figure {
        --figure-size: 70vh;
        border-radius: var(--figure-size);
        max-width: var(--figure-size);
        flex-grow: 10;
    }
    .container-row {
        display:flex;
        justify-content: center;
    }
    .container-column {
        height: 85vh;
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: center;
        flex-direction: column;
    }
    .time {
        flex-grow: 0;
        max-width: 800px;
    }
    .data {
        flex-grow: 0;
        max-width: 800px;
        margin: 2rem;
    }
    </style>
    """
  end
end
