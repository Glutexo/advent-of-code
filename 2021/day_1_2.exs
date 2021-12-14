defmodule Day1 do
  def solve(input) do
    input
    |> Groups.create(3)
    |> Enum.map(&Enum.sum/1)
    |> Groups.create(2)
    |> Enum.count(fn [a, b] -> b > a end)
  end
end


defmodule InputOutput do
  def input(stream) do
    stream
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&String.to_integer/1)
  end

  def output(integer) do
    Integer.to_string(integer) <> "\n"
  end
end


defmodule Groups do
  def create(values, size) do
    values
    |> initialize()
    |> filter(size)
    |> slice(size)
  end

  def initialize(values) do
    Enum.reduce(values, [[]], &reduce/2)
    |> Enum.map(&Enum.reverse/1)
    |> Enum.reverse()
  end

  defp reduce(element, accumulator) do
    [[] | Enum.map(accumulator, &([element | &1]))]
  end

  defp filter(windows, size) do
    Enum.filter(windows, &(length(&1) >= size))
  end

  defp slice(windows, size) do
    Enum.map(windows, &(Enum.slice(&1, 0, size)))
  end

end



# output = File.stream!("input1.txt")
output = File.stream!("input2.txt")
|> InputOutput.input()
|> Day1.solve()
|> InputOutput.output()
IO.write(output)
File.write!("output2.txt", output)
