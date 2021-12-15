defmodule Day1 do
  def solve(input) do
    input
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&String.to_integer/1)
    |> group(3, &Enum.sum/1)
    |> group(2)
    |> Enum.count(fn [a, b] -> b > a end)
    |> Integer.to_string()
  end

  defp group(values, size, transform \\ &(&1)) do
    Enum.reduce(
      values,
      {[], []},
      fn element, {incomplete, complete} ->
        [last | rest] = Enum.map(incomplete ++ [[]], &([element | &1]))
        if length(last) >= size do
          new = Enum.reverse(last) |> transform.()
          {rest, [new | complete]}
        else
          {[last | rest], complete}
        end
      end
    )
    |> elem(1)
    |> Enum.reverse()
  end
end

# result = File.stream!("input1.txt")
result = File.stream!("input2.txt")
|> Day1.solve()
output = result <> "\n"
IO.write(output)
File.write!("output2.txt", output)
