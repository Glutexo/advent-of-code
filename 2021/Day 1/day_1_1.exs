defmodule Day1 do
  defmodule Accumulator do
    defstruct count: 0, previous: nil
  end
  
  def solve(input) do
    input
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(%Accumulator{}, &reduce/2)
    |> Map.get(:count)
    |> Integer.to_string()
  end

  defp reduce(elem, %Accumulator{count: count, previous: previous})
  when elem > previous do
    %Accumulator{count: count + 1, previous: elem}
  end

  defp reduce(elem, %Accumulator{count: count}) do
    %Accumulator{count: count, previous: elem}
  end
end

input = File.stream!("input2.txt")
output = Day1.solve(input) <> "\n"
File.write!("output2.txt", output)
#|> IO.inspect()
