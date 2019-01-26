defmodule Skitcher.Repo do
  use Ecto.Repo,
    otp_app: :skitcher,
    adapter: Ecto.Adapters.Postgres
end
