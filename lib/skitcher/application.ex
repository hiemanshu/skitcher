defmodule Skitcher.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Skitcher.Repo, []}
    ]

    opts = [strategy: :one_for_one, name: Skitcher.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
