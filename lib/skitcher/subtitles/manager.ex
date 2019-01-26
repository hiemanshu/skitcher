defmodule Skitcher.Subtitles.Manager do
  @moduledoc """
    Manages downloading of subtitles from different sources
  """
  alias Skitcher.Subtitles.SubDB
  alias Skitcher.Subtitles.Parser

  def download_and_import(videos_directory) do
    videos_directory
    |> discover_video_files
    |> Enum.map(&download_subtitle(&1))
    |> Enum.map(&parse_subtitle(&1))
    |> Enum.map(&import_subtitle(&1))
  end

  # TODO: Check if files are videos before adding them to a list
  # TODO: Check if files already have a sub downloaded
  defp discover_video_files(videos_directory) do
    Enum.reject(Path.wildcard("#{videos_directory}/**/*.*"), fn file -> 
      Path.extname(file) == ".srt"
    end)
  end

  # TODO: Make pipe do Enum
  defp download_subtitle(video_file) do
    SubDB.Client.download(video_file)
    video_file
  end

  defp parse_subtitle(video_file) do
    srt_file = video_file <> ".srt"
    %{video_file: video_file, subtitle_data: Parser.parse(File.read!(srt_file))}
  end

  defp import_subtitle(%{video_file: file_path, subtitle_data: subtitle_data}) do
    subtitle = %Skitcher.Subtitles.Subtitle{file_path: file_path}
    Enum.map(subtitle_data, fn parsed_subtitle -> 
      if parsed_subtitle do
        Skitcher.Repo.insert(Skitcher.Subtitles.Subtitle.changeset(subtitle, parsed_subtitle))
      end
    end)
  end
end