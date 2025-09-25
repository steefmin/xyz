defmodule SteefMin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SteefMinWeb.Telemetry,
      # Start the PubSub system
      Supervisor.child_spec({Phoenix.PubSub, name: SteefMin.PubSub}, id: :default_phoenix),
      Supervisor.child_spec({Phoenix.PubSub, name: IndexNumber.Number}, id: :application_pubsub),
      # Start the Endpoint (http/https)
      SteefMinWeb.Endpoint,
      # Start a worker by calling: Vlag.Worker.start_link(arg)
      # {Vlag.Worker, arg}
      IndexNumber.Thing
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Vlag.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SteefMinWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
