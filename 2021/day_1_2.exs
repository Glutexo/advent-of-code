defmodule Day1 do
#  defmodule Windows do
#    defstruct previous: [], current: []
#  end
  
#  defmodule Accumulator do
#    defstruct count: 0, windows: %Windows{}
#  end
  
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
#    |> Enum.reduce(%Accumulator{}, &reduce/2)
    |> Map.get(:count)
    |> Integer.to_string()
  end

#  defp reduce(_elem, _accumulator = %Accumulator{}) do
#    
#  end

  def next(elem, old_previous, old_current) do
    _new_previous = old_previous[1..2] ++ [old_current[0]]
    _new_current = old_current[1..2] ++ [elem]
#    %Windows{previous: new_previous, current: new_current}
  end
  
  def append(list, elem) do
    list ++ [elem]
  end
  
end


defmodule Windows do
  defmodule Accumulator do
    defstruct(result: [], element: nil)
  end

  def push(windows, element) do
    accumulator = %Accumulator{element: element}
    Enum.reduce(windows, accumulator, &reduce/2)
  end
  
  defp reduce(element, accumulator) do
    window = [accumulator.element | Enum.slice(element, 0..-2)]
    result = accumulator.result ++ [window]
    next = Enum.at(element, -1)
    %Accumulator{result: result, element: next}
  end

  defp result(window_count) do
    List.duplicate([], window_count)
  end
end

defmodule WindowsTest do
  defmodule TestData do
    defstruct(input: [], element: nil, result: [])
  end

  defmodule TestResult do
    defstruct([:test_data, :result, :passed])
  end

  defmodule Tests do
    @test_data [
      %TestData{
	input: [[2, 1, 0]],
	element: 3,
	result: %Windows.Accumulator{
	  result: [[3, 2, 1]],
	  element: 0
	},
      },
      %TestData{
	input: [[5, 4, 3], [2, 1, 0]],
	element: 6,
	result: %Windows.Accumulator{
	  result: [[6, 5, 4], [3, 2, 1]],
	  element: 0,
	},
      },
      %TestData{
	input: [[8, 7, 6], [5, 4, 3], [2, 1, 0]],
	element: 9,
	result: %Windows.Accumulator{
	  result: [[9, 8, 7], [6, 5, 4], [3, 2, 1]],
	  element: 0,
	},
      },
      %TestData{
	input: [[1, 0]],
	element: 2,
	result: %Windows.Accumulator{
	  result: [[2, 1]],
	  element: 0,
	},
      },
      %TestData{
	input: [[3, 2], [1, 0]],
	element: 4,
	result: %Windows.Accumulator{
	  result: [[4, 3], [2, 1]],
	  element: 0,
	},
      },
      %TestData{
	input: [[5, 4], [3, 2], [1, 0]],
	element: 6,
	result: %Windows.Accumulator{
	  result: [[6, 5], [4, 3], [2, 1]],
	  element: 0,
	},
      },
      %TestData{
	input: [[0]],
	element: 1,
	result: %Windows.Accumulator{
	  result: [[1]],
	  element: 0,
	},
      },
      %TestData{
	input: [[1], [0]],
	element: 2,
	result: %Windows.Accumulator{
	  result: [[2], [1]],
	  element: 0,
	},
      },
      %TestData{
	input: [[2], [1], [0]],
	element: 3,
	result: %Windows.Accumulator{
	  result: [[3], [2], [1]],
	  element: 0,
	},
      },
    ]

    def run() do
      Enum.map(@test_data, &test/1)
    end

    defp test(test_data = %TestData{}) do
      result = Windows.push(test_data.input, test_data.element)
      passed = result == test_data.result
      %TestResult{test_data: test_data, result: result, passed: passed}
    end    
  end
  
end

Windows.push([[0, 1, 2]], 3)
|> IO.inspect()
WindowsTest.Tests.run()
|> IO.inspect(charlists: :as_chars)


#input = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

#Day1.Window.shift(
#  [
#    [1, 2, 3],
#    [4, 5, 6],
#    [7, 8, 9],
#    [10]
#  ]
#) |> IO.inspect(charlists: :as_lists)

#input = File.stream!("input2.txt")
#output = Day1.solve(input) <> "\n"
#File.write!("output2.txt", output)
#|> IO.inspect()
