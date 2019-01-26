defmodule Skitcher.Subtitles.SubDB.Client do
  @moduledoc """
      SubDB Client to search and download subs
  """
  @user_agent "SubDB/1.0 (Skitcher/0.1.0; http://github.com/hiemanshu/skitcher)"
  @base_url "http://sandbox.thesubdb.com/?action=download&hash="

  def download(file_path) do
    hash = Skitcher.Subtitles.SubDB.Hash.generate(file_path)
    download_subtitle(hash)
  end

  defp download_subtitle(hash) do
    url = @base_url <> hash <> "&language=en"

    case HTTPoison.get(url, [{"User-Agent", @user_agent}]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        "Not found :("

      {:error, %HTTPoison.Error{reason: reason}} ->
        reason
    end
  end
end