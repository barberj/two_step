defmodule TwoStepWeb.Router do
  use TwoStepWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TwoStepWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TwoStepWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  scope "/api", TwoStepWeb do
    pipe_through :api
    get "/one", OneController, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TwoStepWeb.Telemetry
    end
  end

  scope "/developer" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :two_step,
      swagger_file: "swagger.json",
      disable_validator: true
  end

  forward "/alternate", TwoStepWeb.AlternateRouter

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "My App"
      }
    }
  end
end
