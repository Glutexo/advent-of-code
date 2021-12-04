defmodule Statistics do
  def combinations([head | tail], count) do
    combinations(tail, count) ++ []
  end

  def combinations([], _) do
    []
  end
end

input = [1, 2, 3, 4]
result = Statistics.combinations(input, 2)
IO.inspect(result)
