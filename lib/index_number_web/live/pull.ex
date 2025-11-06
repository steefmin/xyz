defmodule IndexNumberWeb.Live.Pull do
  use SteefMinWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="pl-10 pt-10 lg:flex lg:items-center lg:justify-between">
      <div class="min-w-0 flex-1">
        <h2 class="text-2xl font-bold leading-7 text-gray-900 sm:truncate sm:text-3xl sm:tracking-tight">
          Steefs assistentie wachtrij
        </h2>
      </div>
    </div>
    <div class="pl-10 lg:flex lg:items-center lg:justify-between">
      <div class="min-w-0 flex-1">
        <div class="mt-1 flex flex-col sm:mt-0 sm:flex-row sm:flex-wrap sm:space-x-6">
          <div class="mt-2 flex items-center text-sm text-gray-500">
            Je nummer is automatisch getrokken.
            <%= if @connected && @number == @called do %>
              Je bent nu aan de beurt! <span class="hero-cake p-2" />
            <% else %>
              Nog even wachten. Je bent straks aan de beurt.
            <% end %>
          </div>
        </div>
      </div>
    </div>
    <div>
      <%= if @connected do %>
        <%= if @number != nil and @called > @number do %>
          <div class="pl-10 pt-2 text-sm text-gray-500">
            Jouw beurt is voorbij.
          </div>
          <button
            type="button"
            class="ml-10 mt-2 inline-flex items-center rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
            phx-click="restart"
          >
            Start opnieuw
          </button>
        <% else %>
          <div class="bg-white py-24 sm:py-32">
            <div class="mx-auto max-w-7xl px-6 lg:px-8">
              <dl class="grid grid-cols-2 gap-x-6 gap-y-16 text-center lg:grid-cols-2">
                <div class="mx-auto flex max-w-xs flex-col gap-y-4">
                  <dt class="text-base leading-7 text-gray-600">
                    <%= if @number != nil do %>
                      Jouw nummer
                    <% end %>
                  </dt>
                  <dd class="order-first text-8xl font-semibold text-gray-900 sm:text-9xl">
                    <%= if @number == nil do %>
                      <div class="cursor-pointer">
                        <button
                          type="button"
                          class="inline-flex items-center rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                          phx-click="pull"
                        >
                          <svg
                            class="-ml-0.5 mr-1.5 h-5 w-5"
                            viewBox="0 0 20 20"
                            fill="currentColor"
                            aria-hidden="true"
                          >
                            <path
                              fill-rule="evenodd"
                              d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z"
                              clip-rule="evenodd"
                            />
                          </svg>
                          Geef me een nummer!
                        </button>
                      </div>
                    <% else %>
                      {@number}
                    <% end %>
                  </dd>
                </div>
                <div class="mx-auto flex max-w-xs flex-col gap-y-4">
                  <dt class="text-base leading-7 text-gray-600">Nummer nu in behandeling</dt>
                  <dd class="order-first text-8xl font-semibold tracking-tight text-gray-900 sm:text-9xl">
                    {@called}
                  </dd>
                </div>
              </dl>
            </div>
          </div>
        <% end %>
      <% end %>
    </div>
    """
  end

  def mount(_params, _data, socket) do
    socket =
      case connected?(socket) do
        false ->
          socket
          |> assign(:connected, false)

        true ->
          IndexNumber.Pubsub.sub()
          keep_alive()

          socket
          |> assign(:number, nil)
          |> assign(:called, IndexNumber.Thing.on_screen())
          |> assign(:connected, true)
      end

    {:ok, socket}
  end

  defp keep_alive() do
    Process.send_after(self(), :ping_client, 120_000)
  end

  def handle_info(:ping_client, socket) do
    keep_alive()
    {:noreply, push_event(socket, "keepalive", %{})}
  end

  def handle_info({:number_called, called_number}, socket) do
    socket = socket |> assign(:called, called_number)
    {:noreply, socket}
  end

  def handle_info(_, socket) do
    {:noreply, socket}
  end

  def handle_event("pull", _data, socket) do
    socket =
      socket
      |> assign(:number, IndexNumber.Thing.pull())

    {:noreply, socket}
  end

  def handle_event("restart", _data, socket) do
    socket =
      socket
      |> assign(:number, nil)

    {:noreply, socket}
  end
end
