defmodule Ctoroulette.Repo do
  use Ecto.Repo,
    otp_app: :ctoroulette,
    adapter: Ecto.Adapters.Postgres
end
