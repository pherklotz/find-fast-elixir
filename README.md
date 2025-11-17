# Find Fast (Elixir Edition)

Simple find tool that searches for regular expressions in files.
The goal of this project is to learn [Elixir](https://elixir-lang.org/). 
**It is not recommended to use this tool in production.**

## Specification

Build a tool that finds regular expressions as fast as possible in certain files of a file tree.
The tool is called with two arguments and runs on the command line.

Example:
```bash
./fifa **/*.ex fu?n
```

- First argument is a glob pattern to select one or more files in a folder structure
- Second argument is a Regular Expression that must be matched
- Output contains the file path to the file that contains the a string that matches the regex
- For each file the line number of the match and the line content is printed

Example Output:
```
lib/find_fast.ex:
        26          |> Enum.map(fn file ->
        27          Task.async(fn ->
        34          |> Enum.each(fn result -> print_result(result) end)
        46          Enum.each(lines, fn {index, line} ->
lib/find_fast/worker.ex:
        27          |> Enum.filter(fn {line, _index} ->
        30          |> Enum.map(fn {line, index} -> {index, String.trim_trailing(line)} end)
```
- Additional output is allowed

Other implementations of this in other languages can be found here:

- [Haskell provided by mgrosser3](https://github.com/mgrosser3/findfast/)
- [Rust provided by ardo314](https://github.com/ardo314/find-fast)

## Installation

Preconditions: Install Erlang and Elixir

- Clone the project
- Windows: Run `.\fifa.bat <File Glob> <Search Term Regex>`
- Linux: Run `mix run -e "FindFast.CLI.main(System.argv) " -- <File Glob> <Search Term Regex>`


