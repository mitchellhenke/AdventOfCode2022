defmodule AdventOfCode2022.Four do
  @external_resource "data/four.txt"
  @jobs File.read!("data/four.txt")
        |> String.split("\n", trim: true)
        |> Enum.map(fn ranges ->
          [range1, range2] = String.split(ranges, ",")
          [beginning_range_1, end_range_1] = String.split(range1, "-")
          [beginning_range_2, end_range_2] = String.split(range2, "-")

          range1 =
            Range.new(
              String.to_integer(beginning_range_1),
              String.to_integer(end_range_1)
            )

          range2 =
            Range.new(
              String.to_integer(beginning_range_2),
              String.to_integer(end_range_2)
            )

          [range1, range2]
        end)

  def first do
    Enum.count(@jobs, fn [job1, job2] ->
      set1 = MapSet.new(Enum.to_list(job1))
      set2 = MapSet.new(Enum.to_list(job2))

      MapSet.subset?(set1, set2) ||
        MapSet.subset?(set2, set1)
    end)
  end

  def second do
    Enum.count(@jobs, fn [job1, job2] ->
      set1 = MapSet.new(Enum.to_list(job1))
      set2 = MapSet.new(Enum.to_list(job2))

      MapSet.size(MapSet.intersection(set1, set2)) > 0 ||
        MapSet.size(MapSet.intersection(set2, set1)) > 0
    end)
  end
end
