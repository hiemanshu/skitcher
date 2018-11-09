defmodule Skitcher.Subtitles.Parser do
  @moduledoc """
    Parses a subtitles (srt) file into an array
  """

  alias Skitcher.Subtitles.Subtitle

  @split_regex ~r/\n\s?\n/
  @parse_regex ~r/(?<order>\d+).*\n(?<start>[\d:,]+)\s+-{2}\>\s+(?<end>[\d:,]+)\n(?<text>[\s\S]*?(?=\n{2}|$))/

  def parse(subtitles) do
    subtitles
    |> split_blocks
    |> Enum.map(&parse_blocks(&1))
    |> Enum.map(&make_subtitle(&1))
  end

  defp split_blocks(subtitles) do
    Regex.split(@split_regex, subtitles)
  end

  defp parse_blocks(block) do
    Regex.named_captures(@parse_regex, block)
  end

  defp make_subtitle(subtitle) do
    Subtitle.make(subtitle)
  end
end