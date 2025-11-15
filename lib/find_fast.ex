defmodule FindFast do
  @moduledoc """
  Documentation for `FindFast`.
  """

  @doc """
  Finds files that match the passed glob pattern (case sensitive) and searchs for the regex in them.

  ## Examples

      iex> FindFast.run("**/*.txt", "Hello \w")
      :ok

  """
  def run(glob, regex) do
    start = Time.utc_now()
    files = FindFast.FileFinder.find(glob)
    IO.write(length(files))
    IO.write(" file(s) found in ")
    IO.write(Time.diff(Time.utc_now(), start, :millisecond))
    IO.puts(" ms")
    start = Time.utc_now()

    tasks =
      files
      |> Enum.map(fn file ->
        Task.async(fn ->
          FindFast.Worker.search(file, regex)
        end)
      end)

    tasks
    |> Task.await_many(:infinity)
    |> Enum.each(fn result -> print_result(result) end)

    IO.write("Search in files took ")
    IO.write(Time.diff(Time.utc_now(), start, :millisecond))
    IO.puts(" ms")

    :ok
  end

  defp print_result({:ok, {file, lines}}) when lines != nil do
    IO.puts(file <> ":")

    Enum.each(lines, fn {index, line} ->
      IO.write("\t")
      IO.write(index)
      IO.write("\t")
      IO.puts(line)
    end)

    :ok
  end

  defp print_result(_), do: :ok
end
