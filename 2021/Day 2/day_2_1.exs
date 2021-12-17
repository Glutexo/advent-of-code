defmodule Position do
  defstruct(horizontal: 0, depth: 0)
end

defmodule Day2 do
  @moves %{
    "forward" => {:horizontal, 1},
    "down" => {:depth, 1},
    "up" => {:depth, -1},
  }
  
  def solve(input) do
    input
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%Position{}, &reduce/2)
    |> calculate()
    |> Integer.to_string()
  end

  defp parse_line(line) do
    [direction, amount] = String.split(line)
    {direction, String.to_integer(amount)}
  end

  defp reduce({direction, amount}, accumulator = %Position{}) do
    {axis, coeficient} = Map.get(@moves, direction)
    old_position = Map.get(accumulator, axis)
    new_position = old_position + amount * coeficient
    Map.put(accumulator, axis, new_position)
  end

  defp calculate(%Position{horizontal: horizontal, depth: depth}) do
    horizontal * depth
  end
end

#result = File.stream!("input1.txt")
result = File.stream!("input2.txt")
|> Day2.solve()
output = result <> "\n"
IO.write(output)
#File.write!("output1.txt", output)
File.write!("output2.txt", output)
