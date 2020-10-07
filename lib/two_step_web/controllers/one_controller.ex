defmodule TwoStepWeb.OneController do
  use TwoStepWeb, :controller
  use PhoenixSwagger

  swagger_path :index do
    get("/one")
    produces("application/json")
    response(200, "OK", Schema.ref(:One))
  end

  def index(conn, _params) do
    json(conn, %{one: true})
  end

  def swagger_definitions do
    %{
      One:
        swagger_schema do
          title("One")

          properties do
            one(:string, "One")
          end
        end
    }
  end
end
