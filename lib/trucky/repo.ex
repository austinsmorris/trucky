defmodule Trucky.Repo do
  use Ecto.Repo,
    otp_app: :trucky,
    adapter: Ecto.Adapters.Postgres
end
