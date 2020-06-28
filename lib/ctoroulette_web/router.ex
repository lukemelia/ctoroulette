defmodule CtorouletteWeb.Router do
  use CtorouletteWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  import Plug.BasicAuth
  
  pipeline :protected do
    # if System.get_env("ADMIN_USERNAME") || System.get_env("ADMIN_PASSWORD") do
    plug :basic_auth, Application.compile_env(:ctoroulette, :basic_auth)
    # end
  end

  scope "/", CtorouletteWeb do
    pipe_through :browser

    get "/", PageController, :index
  end


  scope "/admin", CtorouletteWeb do
    pipe_through [:browser, :protected]
  
    resources "/destinations", DestinationController
  end
  
  import Redirect
  redirect "/admin/", "/admin/destinations", :temporary

  # Other scopes may use custom stacks.
  # scope "/api", CtorouletteWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  import Phoenix.LiveDashboard.Router

  scope "/" do
    pipe_through [:browser, :protected]
    live_dashboard "/dashboard", metrics: CtorouletteWeb.Telemetry
  end
end
