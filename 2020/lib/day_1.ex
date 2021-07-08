defmodule Day1 do
  @expected 2020
  
  def solve(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Helpers.combinations()
    |> Enum.find(&match/1)
    |> result()
  end

  defp match({a, b}) do
    a + b == @expected
  end

  defp result({a, b}) do
    a * b
  end
end
