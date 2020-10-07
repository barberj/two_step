defmodule TwoStepWeb.TwoController do
  use TwoStepWeb, :controller
  use PhoenixSwagger

  swagger_path :index do
    get("/two")
    produces("application/json")
    response(200, "OK", Schema.ref(:Two))
  end

  def index(conn, _params) do
    json(conn, %{two: true})
  end

  def swagger_definitions do
    %{
      Two:
        swagger_schema do
          title("Two")

          properties do
            two(:string, "Two")
          end
        end
    }
  end
end
