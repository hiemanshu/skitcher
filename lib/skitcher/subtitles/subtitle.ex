defmodule Skitcher.Subtitles.Subtitle do
  @moduledoc """
    Subtitle model
  """
  use Ecto.Schema

  schema "subtitles" do
    field :start_time, :time
    field :end_time, :time
    field :text, :string
    field :file_path, :string
  end

  def changeset(subtitle, params \\ %{}) do
    subtitle
    |> Ecto.Changeset.cast(params, [:start_time, :end_time, :text, :file_path])
    |> Ecto.Changeset.validate_required([:start_time, :end_time, :text, :file_path])
  end
end