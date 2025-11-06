defmodule SteefMinWeb.Router do
  use SteefMinWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SteefMinWeb.Layouts, :root}
    plug :protect_from_forgery

    # , %{
    plug :put_secure_browser_headers
    #    "content-security-policy" => "default-src 'self'; style-src 'self' 'unsafe-inline'"
    # }
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SteefMinWeb do
    pipe_through :browser

    live "/", Live.Home
  end

  scope "/", VlagWeb, host: ["flag.", "vlag."] do
    pipe_through :browser

    live("/", Live.Index)
    live("/simulate/:date", Live.Index)
  end

  scope "/", IndexNumberWeb, host: ["wachtrij."] do
    pipe_through :browser
    live "/", Live.Pull
    live "/pop", Live.Pop
    live "/screen", Live.Screen
  end

  # Other scopes may use custom stacks.
  # scope "/api", SteefMinWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:steef_min, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SteefMinWeb.Telemetry
    end
  end
end
