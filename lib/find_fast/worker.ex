defmodule FindFast.Worker do
  @moduledoc """
  Searches a regex in a file and returns a list of the matching lines and the
  line number.
  """

  @doc """
  Searches the file to find the regex in the file. It returns a list of matching
  lines and line number.
  """
  @spec search(String.t(), String.t()) :: {:ok, {String.t(), list()} | nil} | {:error, any()}
  def search(file, pattern) do
    case Regex.compile(pattern) do
      {:ok, regex} ->
        search_regex(file, regex)

      {:error, reason} ->
        {:error, {:regex_error, reason}}
    end
  end

  defp search_regex(file, regex) do
    try do
      matching_lines =
        File.stream!(file, :line, [])
        |> Enum.with_index(1)
        |> Enum.filter(fn {line, _index} ->
          Regex.match?(regex, line)
        end)
        |> Enum.map(fn {line, index} -> {index, String.trim_trailing(line)} end)

      if matching_lines == [] do
        {:ok, nil}
      else
        {:ok, {file, matching_lines}}
      end
    catch
      :error, %File.Error{reason: reason} -> {:error, {:file_read_error, reason}}
      :error, error -> {:error, error}
    end
  end
end
