defmodule Skitcher.Repo.Migrations.CreateSubtitles do
  use Ecto.Migration

  def change do
    create table(:subtitles) do
      add :start_time, :time, null: false
      add :end_time, :time, null: false
      add :text, :text, null: false
      add :file_path, :text, null: false
    end
  end
end
