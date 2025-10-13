defmodule IndexNumberWeb.Live.Screen do
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
            Dit nummer is nu aan de beurt:
          </div>
        </div>
      </div>
    </div>
    <div>
      <%= if @connected do %>
        <div class="bg-white py-24 sm:py-32">
          <div class="mx-auto max-w-7xl px-6 lg:px-8">
            <dl class="grid grid-cols-1 gap-x-8 gap-y-16 text-center lg:grid-cols-1">
              <div class="mx-auto flex max-w-xs flex-col gap-y-4">
                <dt class="text-base leading-7 text-gray-600">Nummer nu in behandeling</dt>
                <dd class="order-first text-9xl font-semibold tracking-tight text-gray-900 sm:text-9xl">
                  {@called}
                </dd>
              </div>
            </dl>
          </div>
        </div>
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
          |> assign(:number, IndexNumber.Thing.pull())
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
end
