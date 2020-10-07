defmodule TwoStepWeb.AlternateRouter do
  use TwoStepWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TwoStepWeb do
    pipe_through :api
    get "/two", TwoController, :index
  end

  scope "/developer" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :two_step,
      swagger_file: "alternate_swagger.json",
      disable_validator: true
  end

  forward "/alternate", TwoStepWeb.AlternateRouter

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Alternate Swagger"
      }
    }
  end
end
