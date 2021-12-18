defmodule Position do
  defstruct(horizontal: 0, depth: 0, aim: 0)

  def move(
    {:forward, amount},
    position = %Position{
      horizontal: horizontal,
      depth: depth,
      aim: aim,
    }
  ) do
    %Position{
      position |
      horizontal: horizontal + amount,
      depth: depth + aim * amount
    }
  end

 def move({:down, amount}, position = %Position{aim: aim}) do
    %Position{position | aim: aim + amount}
  end

 def move({:up, amount}, position = %Position{aim: aim}) do
    %Position{position | aim: aim - amount}
  end
end

defmodule Day2 do
  def solve(input) do
    input
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%Position{}, &Position.move/2)
    |> calculate()
    |> Integer.to_string()
  end

  defp parse_line(line) do
    [line_direction, line_amount] = String.split(line)
    move_direction = String.to_atom(line_direction)
    move_amount = String.to_integer(line_amount)
    {move_direction, move_amount}
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
