defmodule Helpers do
  def permutations([]) do
    []
  end

  def permutations([head | tail]) do
    permutations(head, tail) ++ permutations(tail)
  end

  def permutations(head, tail) do
    Enum.map(tail, fn item -> {head, item} end)
  end
end
