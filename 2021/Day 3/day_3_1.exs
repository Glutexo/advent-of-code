defmodule Day3 do
  def solve(input) do
    input
    |> Enum.map(&String.trim_trailing/1)
    |> transpose()
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&Enum.frequencies/1)
    |> Enum.map(&Enum.min_max_by(&1, fn {_, v} -> v end))
    |> Enum.map(fn min_max ->
      min_max
      |> Tuple.to_list()
      |> Enum.map(fn {k, _} -> k end)
      |> Enum.join()
    end)
    |> transpose()
    |> Enum.map(&String.to_integer(&1, 2))
    |> Enum.product()
    |> Integer.to_string()
  end

  defp transpose(lines) do
    Enum.reduce(lines, [], &transpose_reduce_lines/2)
  end

  defp transpose_reduce_lines(element, []) do
    len = String.length(element)
    accumulator = List.duplicate("", len)
    transpose_reduce_lines(element, accumulator)
  end

  defp transpose_reduce_lines(element, accumulator) do
    element
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.reduce(accumulator, &transpose_reduce_line/2)
  end

  defp transpose_reduce_line({value, index}, accumulator) do
    old = Enum.at(accumulator, index, "")
    new = old <> value
    List.replace_at(accumulator, index, new)
  end
end



#result = File.stream!("input1.txt")
result = File.stream!("input2.txt")
|> Day3.solve()
output = result <> "\n"
IO.write(output)
File.write!("output1.txt", output)

