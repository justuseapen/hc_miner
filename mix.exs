defmodule HcMiner.MixProject do
  use Mix.Project

  def project do
    [
      app: :hc_miner,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {HcMiner.Application, []}
    ]
  end

  defp deps do
    [
      {:crawly, "~> 0.16.0"},
      {:ecto_sql, "~> 3.2"},
      {:floki, "~> 0.35.0"},
      {:jason, "~> 1.2"},
      {:postgrex, "~> 0.15"},
      {:timex, "~> 3.7"}
    ]
  end
end
