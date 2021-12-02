defmodule Day1 do
  defmodule Windows do
    defstruct previous: [], current: []
  end
  
  defmodule Accumulator do
    defstruct count: 0, windows: %Windows{}
  end
  
  defmodule Window do
    def shift(windows) do
      Enum.reduce(windows, [], &shift_reduce/2)
    end

    defp shift_reduce(elem, accumulator) do
      shift_reduce_unchanged_part(accumulator)
      ++ shift_reduce_changed_part(elem, accumulator)
      ++ shift_reduce_new_part(elem)
    end

    defp shift_reduce_unchanged_part(accumulator) do
      Enum.slice(accumulator, 0..-2)
    end

    defp shift_reduce_changed_part(_elem, []) do
      []
    end

    defp shift_reduce_changed_part(elem, accumulator) do
      [Enum.at(accumulator, -1) ++ [Enum.at(elem, 0)]]
    end

    defp shift_reduce_new_part(elem) when length(elem) <= 1 do
      []
    end

    defp shift_reduce_new_part(elem) do
      [Enum.slice(elem, 1..-1)]
    end
  end

  def solve(input) do
    input
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(%Accumulator{}, &reduce/2)
    |> Map.get(:count)
    |> Integer.to_string()
  end

  defp reduce(_elem, _accumulator = %Accumulator{}) do
    
  end

  def next(elem, old_previous, old_current) do
    new_previous = old_previous[1..2] ++ [old_current[0]]
    new_current = old_current[1..2] ++ [elem]
    %Windows{previous: new_previous, current: new_current}
  end
  
  def append(list, elem) do
    list ++ [elem]
  end
  
end


Day1.Window.shift(
  [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [10]
  ]
) |> IO.inspect(charlists: :as_lists)

#input = File.stream!("input2.txt")
#output = Day1.solve(input) <> "\n"
#File.write!("output2.txt", output)
#|> IO.inspect()
