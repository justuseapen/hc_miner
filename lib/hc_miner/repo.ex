defmodule HcMiner.Repo do
  use Ecto.Repo,
    otp_app: :hc_miner,
    adapter: Ecto.Adapters.Postgres
end
