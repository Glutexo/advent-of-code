defmodule Day1 do
  @expected 2020
  
  def solve(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> permutations()
    |> Enum.find(&match/1)
    |> result()
  end

  defp permutations([]) do
    []
  end

  defp permutations([head | tail]) do
    permutations(head, tail) ++ permutations(tail)
  end

  defp permutations(head, tail) do
    Enum.map(tail, fn item -> {head, item} end)
  end

  defp match({a, b}) do
    a + b == @expected
  end

  defp result({a, b}) do
    a * b
  end
end

#File.read!("day_1_example.txt")
File.read!("day_1.txt")
|> Day1.solve()
|> IO.inspect()
