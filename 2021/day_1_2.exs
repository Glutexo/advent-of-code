defmodule Day1 do
  def solve(input) do
    input
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&String.to_integer/1)
    |> group(3)
    |> Enum.map(&Enum.sum/1)
    |> group(2)
    |> Enum.count(fn [a, b] -> b > a end)
    |> Integer.to_string()
  end

  defp group(values, size) do
    Enum.reduce(
      values,
      [[]],
      fn element, accumulator ->
        [[] | Enum.map(accumulator, &([element | &1]))]
      end
    )
    |> Enum.map(&Enum.reverse/1)
    |> Enum.reverse()
    |> Enum.filter(&(length(&1) >= size))
    |> Enum.map(&(Enum.slice(&1, 0, size)))
  end
end

# result = File.stream!("input1.txt")
result = File.stream!("input2.txt")
|> Day1.solve()
output = result <> "\n"
IO.write(output)
File.write!("output2.txt", output)
