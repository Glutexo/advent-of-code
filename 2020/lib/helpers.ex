defmodule Helpers do
  def combinations([]) do
    []
  end

  def combinations([head | tail]) do
    combinations(head, tail) ++ combinations(tail)
  end

  def combinations(head, tail) do
    Enum.map(tail, fn item -> {head, item} end)
  end
end
