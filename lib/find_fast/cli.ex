defmodule FindFast.CLI do
  @moduledoc """
  The entry point into the find fast CLI application.
  """

  @doc """
  Starts the find process via CLI. It expects at least two arguments: a file glob and a regex to search in the files that match the glob.
  """
  def main([glob, regex]) do
    start = Time.utc_now()
    FindFast.run(glob, regex)
    IO.write("Search duration: ")
    IO.write(Time.diff(Time.utc_now(), start, :millisecond))
    IO.write(" ms\n")
    :ok
  end

  def main(_) do
    IO.puts("❌ fifa expects exactly two arguments.\nUsage: fifa <file glob> <search term regex>")
    System.halt(1)
  end
end
