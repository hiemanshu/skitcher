defmodule Skitcher.Subtitles.Subtitle do
  @moduledoc """
    Subtitle model
  """
  defstruct [:start_time, :end_time, :text
]
  def make(subtitle) do
    if subtitle do
      %Skitcher.Subtitles.Subtitle{
        start_time: Time.from_iso8601!(subtitle["start"]),
        end_time: Time.from_iso8601!(subtitle["end"]),
        text: Regex.replace(~r/\n/, subtitle["text"], " ")
      }
    end
  end
end