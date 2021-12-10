defmodule Day1 do
#  defmodule Accumulator do
#    defstruct count: 0, windows: %Windows{}
#  end
  
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
    defstruct(result: [], items: [])
  end

  def init(count) do
    List.duplicate([], count)
  end

  def push(windows, items, size) do
    initial = %Accumulator{items: items}
    reducer = fn element, accumulator ->
      reduce(element, accumulator, size)
    end
    Enum.reduce(windows, initial, reducer)
  end

  defp reduce(element, accumulator, size) do
    extended = accumulator.items ++ element
    {window, next} = Enum.split(extended, size)
    result = accumulator.result ++ [window]
    %Accumulator{result: result, items: next}
  end
end

defmodule WindowsTest do
  defmodule TestData do
    defstruct([:input, :items, :size, :result])
  end

  defmodule TestResult do
    defstruct([:test_data, :result, :passed])
  end

  defmodule Tests do
    @test_data [
      %TestData{
        input: [[2, 1, 0]],
        items: [3],
        size: 3,
        result: %Windows.Accumulator{
          result: [[3, 2, 1]],
          items: [0]
        },
      },
      %TestData{
        input: [[5, 4, 3], [2, 1, 0]],
        items: [6],
        size: 3,
        result: %Windows.Accumulator{
          result: [[6, 5, 4], [3, 2, 1]],
          items: [0],
        },
      },
      %TestData{
        input: [[8, 7, 6], [5, 4, 3], [2, 1, 0]],
        items: [9],
        size: 3,
        result: %Windows.Accumulator{
          result: [[9, 8, 7], [6, 5, 4], [3, 2, 1]],
          items: [0],
        },
      },
      %TestData{
        input: [[1, 0]],
        items: [2],
        size: 2,
        result: %Windows.Accumulator{
          result: [[2, 1]],
          items: [0],
        },
      },
      %TestData{
        input: [[3, 2], [1, 0]],
        items: [4],
        size: 2,
        result: %Windows.Accumulator{
          result: [[4, 3], [2, 1]],
          items: [0],
        },
      },
      %TestData{
        input: [[5, 4], [3, 2], [1, 0]],
        items: [6],
        size: 2,
        result: %Windows.Accumulator{
          result: [[6, 5], [4, 3], [2, 1]],
          items: [0],
        },
      },
      %TestData{
        input: [[0]],
        items: [1],
        size: 1,
        result: %Windows.Accumulator{
          result: [[1]],
          items: [0],
        },
      },
      %TestData{
        input: [[1], [0]],
        items: [2],
        size: 1,
        result: %Windows.Accumulator{
          result: [[2], [1]],
          items: [0],
        },
      },
      %TestData{
        input: [[2], [1], [0]],
        items: [3],
        size: 1,
        result: %Windows.Accumulator{
          result: [[3], [2], [1]],
          items: [0],
        },
      },
      %TestData{
        input: [[], [], []],
        items: [0],
        size: 3,
        result: %Windows.Accumulator{
          result: [[0], [], []],
          items: [],
        },
      },
      %TestData{
        input: [[0], [], []],
        items: [1],
        size: 3,
        result: %Windows.Accumulator{
          result: [[1, 0], [], []],
          items: [],
        },
      },
      %TestData{
        input: [[1, 0], [], []],
        items: [2],
        size: 3,
        result: %Windows.Accumulator{
          result: [[2, 1, 0], [], []],
          items: [],
        },
      },
      %TestData{
        input: [[2, 1, 0], [], []],
        items: [3],
        size: 3,
        result: %Windows.Accumulator{
          result: [[3, 2, 1], [0], []],
          items: [],
        },
      },
      %TestData{
        input: [[3, 2, 1], [0], []],
        items: [4],
        size: 3,
        result: %Windows.Accumulator{
          result: [[4, 3, 2], [1, 0], []],
          items: [],
        },
      },
      %TestData{
        input: [[4, 3, 2], [1, 0], []],
        items: [5],
        size: 3,
        result: %Windows.Accumulator{
          result: [[5, 4, 3], [2, 1, 0], []],
          items: [],
        },
      },
      %TestData{
        input: [[5, 4, 3], [2, 1, 0], []],
        items: [6],
        size: 3,
        result: %Windows.Accumulator{
          result: [[6, 5, 4], [3, 2, 1], [0]],
          items: [],
        },
      },
      %TestData{
        input: [[6, 5, 4], [3, 2, 1], [0]],
        items: [7],
        size: 3,
        result: %Windows.Accumulator{
          result: [[7, 6, 5], [4, 3, 2], [1, 0]],
          items: [],
        },
      },
      %TestData{
        input: [[7, 6, 5], [4, 3, 2], [1, 0]],
        items: [8],
        size: 3,
        result: %Windows.Accumulator{
          result: [[8, 7, 6], [5, 4, 3], [2, 1, 0]],
          items: [],
        },
      },
    ]

    def run() do
      Enum.map(@test_data, &test/1)
    end

    defp test(test_data = %TestData{}) do
      result = Windows.push(test_data.input, test_data.items, test_data.size)
      passed = result == test_data.result
      %TestResult{test_data: test_data, result: result, passed: passed}
    end    
  end
  
end

#Windows.push([[0, 1, 2]], [3], 3)
#|> IO.inspect()
IO.puts("Failed tests:")
WindowsTest.Tests.run()
|> Enum.filter(&(!&1.passed))
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
