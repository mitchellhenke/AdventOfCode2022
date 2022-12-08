defmodule AdventOfCode2022.Seven do
  @external_resource "data/seven.txt"
  @terminal Regex.split(~r/(^\$ |\n\$ )/, File.read!("data/seven.txt"), trim: true)
            |> Enum.map(fn command_block ->
              String.split(command_block, "\n", trim: true)
            end)

  def first do
    {_, files} =
      Enum.reduce(@terminal, {[], %{}}, fn commands, {path, files} ->
        [first | rest] = commands

        cond do
          String.starts_with?(first, "cd") ->
            ["cd", dir] = String.split(first, " ")
            new_path = change_directory(path, dir)
            {new_path, files}

          first == "ls" ->
            updated_files =
              Enum.reduce(rest, files, fn file, updated_files ->
                if String.starts_with?(file, "dir") do
                  updated_files
                else
                  [size, filename] = String.split(file, " ")
                  Map.put(updated_files, {path, filename}, String.to_integer(size))
                end
              end)

            {path, updated_files}

          true ->
            IO.inspect("uh oh")
            {path, files}
        end
      end)
      |> IO.inspect()

    Enum.reduce(files, %{}, fn {{path, _file}, size}, dir_size ->
      {_, paths} =
        Enum.reduce(path, {nil, []}, fn path_part, {current, paths} ->
          if paths == [] && path_part == "/" do
            {"/", ["/"]}
          else
            {Path.join(current, path_part), [Path.join(current, path_part) | paths]}
          end
        end)

      Enum.reduce(paths, dir_size, fn path, dir_size ->
        Map.update(dir_size, path, size, &(&1 + size))
      end)
    end)
    |> Enum.filter(fn {key, value} ->
      key != "/" && value <= 100_000
    end)
    |> Enum.into(%{})
    |> Map.values()
    |> Enum.sum()
  end

  def second do
    {_, files} =
      Enum.reduce(@terminal, {[], %{}}, fn commands, {path, files} ->
        [first | rest] = commands

        cond do
          String.starts_with?(first, "cd") ->
            ["cd", dir] = String.split(first, " ")
            new_path = change_directory(path, dir)
            {new_path, files}

          first == "ls" ->
            updated_files =
              Enum.reduce(rest, files, fn file, updated_files ->
                if String.starts_with?(file, "dir") do
                  updated_files
                else
                  [size, filename] = String.split(file, " ")
                  Map.put(updated_files, {path, filename}, String.to_integer(size))
                end
              end)

            {path, updated_files}

          true ->
            IO.inspect("uh oh")
            {path, files}
        end
      end)

    dir_sizes =
      Enum.reduce(files, %{}, fn {{path, _file}, size}, dir_size ->
        {_, paths} =
          Enum.reduce(path, {nil, []}, fn path_part, {current, paths} ->
            if paths == [] && path_part == "/" do
              {"/", ["/"]}
            else
              {Path.join(current, path_part), [Path.join(current, path_part) | paths]}
            end
          end)

        Enum.reduce(paths, dir_size, fn path, dir_size ->
          Map.update(dir_size, path, size, &(&1 + size))
        end)
      end)

    root_size = Map.get(dir_sizes, "/")
    available_size = 70_000_000 - root_size
    needed_size = 30_000_000 - available_size

    Enum.filter(dir_sizes, fn {_key, value} ->
      value > needed_size
    end)
    |> Enum.min_by(fn {_key, value} ->
      value - needed_size
    end)
  end

  defp change_directory(current_path, dir) do
    if dir == ".." do
      Enum.drop(current_path, -1)
    else
      current_path ++ [dir]
    end
  end
end
