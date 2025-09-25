defmodule IndexNumberWeb.Live.Pop do
  use SteefMinWeb, :live_view

  def render(assigns) do
    ~H"""
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
            <dl class="grid grid-cols-2 gap-x-8 gap-y-16 text-center lg:grid-cols-2">
              <div class="mx-auto flex max-w-xs flex-col gap-y-4">
                <dt class="text-base leading-7 text-gray-600">Wachtenden</dt>
                <dd class="order-first text-8xl font-semibold tracking-tight text-gray-900 sm:text-9xl">
                  <%= @waiting %>
                </dd>
              </div>
              <div class="mx-auto flex max-w-xs flex-col gap-y-4">
                <dt class="text-base leading-7 text-gray-600">Nummer nu in behandeling</dt>
                <dd class="order-first text-8xl font-semibold tracking-tight text-gray-900 sm:text-9xl">
                  <%= @called %>
                </dd>
              </div>
            </dl>
          </div>
        </div>
        <div class="bg-white py-24 sm:py-32">
          <div class="mx-auto max-w-7xl px-6 lg:px-8">
            <dl class="grid grid-cols-1 gap-x-8 gap-y-16 text-center lg:grid-cols-1">
              <div class="sm:ml-3">
                <button
                  type="button"
                  class="inline-flex items-center rounded-md bg-indigo-600 disabled:bg-gray-300 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                  phx-click="next"
                  disabled={@waiting == 0}
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
                  Volgende!
                </button>
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

          socket
          |> assign(:called, IndexNumber.Thing.on_screen())
          |> assign(:waiting, IndexNumber.Thing.waiting())
          |> assign(:connected, true)
      end

    {:ok, socket}
  end

  def handle_event("next", _value, socket) do
    socket =
      socket
      |> assign(:called, IndexNumber.Thing.next())
      |> assign(:waiting, IndexNumber.Thing.waiting())

    {:noreply, socket}
  end

  def handle_info({:number_called, called_number}, socket) do
    socket = socket |> assign(:called, called_number)
    {:noreply, socket}
  end

  def handle_info({:number_pulled, _pulled_number}, socket) do
    socket = socket |> assign(:waiting, IndexNumber.Thing.waiting())
    {:noreply, socket}
  end

  def handle_info(_, socket) do
    {:noreply, socket}
  end
end
