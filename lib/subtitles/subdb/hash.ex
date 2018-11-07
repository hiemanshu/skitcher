defmodule Skitcher.Subtitles.SubDB.Hash do
    @moduledoc """
        Creates a hash of the video who's file path is given.

        Uses the first and last 64kb of the video file, combines them, and 
        generates a md5 hash of the resulting data. 
    """
    @chunk_size 64 * 1024 # 64KB

    def generate(file_path) do
        file_path
        |> read_file_chunks
        |> combine_chunks
        |> encode
    end

    defp read_file_chunks(file_path) do
        File.open!(file_path, [:read, :binary], fn file -> 
            start_chunk = IO.binread(file, @chunk_size)
            :file.position(file, {:eof, -@chunk_size})
            end_chunk = IO.binread(file, @chunk_size)
            {start_chunk, end_chunk}
        end)
    end

    defp combine_chunks({start_chunk, end_chunk}) do
        start_chunk <> end_chunk
    end

    defp encode(chunks) do
        Base.encode16(:erlang.md5(chunks), case: :lower)
    end
end
