defmodule FindFast.FileFinder do
  @moduledoc """
  Contains the file find logic.
  """

  @spec find(String.t()) :: [String.t()]
  def find(glob) do
    Path.wildcard(glob)
  end

  def find_all(start_path) do
    File.ls(start_path)
  end
end
