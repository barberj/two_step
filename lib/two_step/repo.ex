defmodule TwoStep.Repo do
  use Ecto.Repo,
    otp_app: :two_step,
    adapter: Ecto.Adapters.Postgres
end
