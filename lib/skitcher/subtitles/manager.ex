defmodule Skitcher.Subtitles.Manager do
  @moduledoc """
    Manages downloading of subtitles from different sources
  """
  alias Skitcher.Subtitles.SubDB
  alias Skitcher.Subtitles.Parser

  def download_and_import(videos_directory) do
    download_subtitles(videos_directory)
    import_subtitles(videos_directory)
  end

  defp download_subtitles(videos_directory) do
    videos_directory
    |> discover_video_files
    |> Enum.map(&download_subtitle(&1))
  end

  defp import_subtitles(videos_directory) do
    videos_directory
    |> discover_srt_files
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
  end

  defp discover_srt_files(videos_directory) do
    Path.wildcard("#{videos_directory}/**/*.srt")
  end

  defp parse_subtitle(srt_file) do
    Parser.parse(File.read!(srt_file))
  end

  defp import_subtitle(subtitle_data) do
    IO.inspect(subtitle_data)
  end
end