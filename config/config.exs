# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :skitcher, Skitcher.Repo,
  database: "skitcher",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :skitcher, ecto_repos: [Skitcher.Repo]
