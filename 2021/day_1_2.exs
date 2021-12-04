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
    defstruct(result: [], number: nil)
  end

  def run(input, number) do
    Enum.reduce(
      Enum.reverse(input),
      %Accumulator{number: number},
      &reduce/2
    )
  end
  
  defp reduce(element, accumulator) do
    window = push(element, accumulator.number)
    result = [window | accumulator.result]
    number = Enum.at(element, 0)
    %Accumulator{result: result, number: number}
  end

  defp push(window, number) do
    Enum.slice(window, 1..-1) ++ [number]
  end
end

defmodule WindowsTest do
  defmodule TestData do
    defstruct(input: [], number: nil, result: [])
  end

  defmodule TestResult do
    defstruct([:input, :number, :result])
  end

  defmodule Tests do
    @test_data [
      %TestData{
	input: [[0, 1, 2]],
	number: 3,
	result: %Windows.Accumulator{
	  result: [[1, 2, 3]],
	  number: 0
	},
      },
      %TestData{
	input: [[0, 1, 2], [3, 4, 5]],
	number: 6,
	result: %Windows.Accumulator{
	  result: [[1, 2, 3], [4, 5, 6]],
	  number: 0,
	},
      },
      %TestData{
	input: [[0, 1, 2], [3, 4, 5], [6, 7, 8]],
	number: 9,
	result: %Windows.Accumulator{
	  result: [[1, 2, 3], [4, 5, 6], [7, 8, 9]],
	  number: 0,
	},
      },
      %TestData{
	input: [[0, 1]],
	number: 2,
	result: %Windows.Accumulator{
	  result: [[1, 2]],
	  number: 0,
	},
      },
      %TestData{
	input: [[0, 1], [2, 3]],
	number: 4,
	result: %Windows.Accumulator{
	  result: [[1, 2], [3, 4]],
	  number: 0,
	},
      },
      %TestData{
	input: [[0, 1], [2, 3], [4, 5]],
	number: 6,
	result: %Windows.Accumulator{
	  result: [[1, 2], [3, 4], [5, 6]],
	  number: 0,
	},
      },
      %TestData{
	input: [[0]],
	number: 1,
	result: %Windows.Accumulator{
	  result: [[1]],
	  number: 0,
	},
      },
    ]

    def run() do
      Enum.map(@test_data, &test/1)
    end

    defp test(%TestData{input: input, number: number, result: result}) do
      test_result = Windows.run(input, number) == result
      %TestResult{input: input, number: number, result: test_result}
    end    
  end
  
end

Windows.run([[0, 1, 2]], 3)
|> IO.inspect()
WindowsTest.Tests.run()
|> IO.inspect()


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
