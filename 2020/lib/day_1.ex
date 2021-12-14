defmodule Day1 do
  @expected 2020
  expected = 2020
   
  
  def solve(input) do
    input
    |> String.split()
    |> MapSet.new(&String.to_integer/1)
    |> Enum.map(&(&1))
    |> IO.inspect()
    #|> Helpers.combinations()
    #|> Enum.find(&match/1)
    #|> result()
  end

  defp match({a, b}) do
    a + b == @expected
  end

  defp result({a, b}) do
    a * b
  end
end
