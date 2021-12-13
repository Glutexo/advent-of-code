defmodule Day1 do
  @size 3
  
  def solve(input) do
    input
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&String.to_integer/1)
    |> reduce()
    |> IO.inspect()
    |> Enum.filter(&filter/1)
    |> Enum.map(&sum/1)
    |> Enum.count(&compare/1)
    |> Integer.to_string()
  end

  defp reduce(input) do
    windows = Windows.init(2)
    Enum.reduce(input, [windows], &collect/2)
  end

  defp collect(element, accumulator = [head | _tail]) do
    {windows, _} = Windows.push(head, [element], @size)
    [windows | accumulator]
  end

  defp filter(element) do
    Windows.complete?(element, @size)
  end

  defp sum(element) do
    Enum.map(element, &Enum.sum/1)
  end

  defp compare([first, second]) do
    first > second
  end
end


defmodule Windows do
  def init(count) do
    List.duplicate([], count)
  end

  def complete?(windows, size) do
    Enum.all?(windows, fn element ->
      length(element) == size
    end)
  end

  def push(windows, items, size) do
    initial = {[], items}
    reducer = fn element, accumulator ->
      reduce(element, accumulator, size)
    end
    Enum.reduce(windows, initial, reducer)
  end

  defp reduce(element, {windows, items}, size) do
    extended = items ++ element
    {window, next} = Enum.split(extended, size)
    result = windows ++ [window]
    {result, next}
  end
end

defmodule TestResult do
  defstruct([:test_data, :result, :passed])
end

defmodule TestData do
  defstruct([:input, :result])
end


defmodule WindowsTest do
  defmodule TestInput do
    defstruct([:input, :items, :size])
  end

  defmodule Tests do
    @test_data [
      %TestData{
        input: %TestInput{
          input: [[2, 1, 0]],
          items: [3],
          size: 3,
        },
        result: {
          [[3, 2, 1]],
          [0]
        },
      },
      %TestData{
        input: %TestInput{
          input: [[5, 4, 3], [2, 1, 0]],
          items: [6],
          size: 3,
        },
        result: {
          [[6, 5, 4], [3, 2, 1]],
          [0],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[8, 7, 6], [5, 4, 3], [2, 1, 0]],
          items: [9],
          size: 3,
        },
        result: {
          [[9, 8, 7], [6, 5, 4], [3, 2, 1]],
          [0],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[1, 0]],
          items: [2],
          size: 2,
        },
        result: {
          [[2, 1]],
          [0],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[3, 2], [1, 0]],
          items: [4],
          size: 2,
        },
        result: {
          [[4, 3], [2, 1]],
          [0],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[5, 4], [3, 2], [1, 0]],
          items: [6],
          size: 2,
        },
        result: {
          [[6, 5], [4, 3], [2, 1]],
          [0],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[0]],
          items: [1],
          size: 1,
        },
        result: {
          [[1]],
          [0],
        },
      },
      %TestData{
        input: %TestInput{ 
          input: [[1], [0]],
          items: [2],
          size: 1,
        },
        result: {
          [[2], [1]],
          [0],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[2], [1], [0]],
          items: [3],
          size: 1,
        },
        result: {
          [[3], [2], [1]],
          [0],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[], [], []],
          items: [0],
          size: 3,
        },
        result: {
          [[0], [], []],
          [],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[0], [], []],
          items: [1],
          size: 3,
        },
        result: {
          [[1, 0], [], []],
          [],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[1, 0], [], []],
          items: [2],
          size: 3,
        },
        result: {
          [[2, 1, 0], [], []],
          [],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[2, 1, 0], [], []],
          items: [3],
          size: 3,
        },
        result: {
          [[3, 2, 1], [0], []],
          [],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[3, 2, 1], [0], []],
          items: [4],
          size: 3,
        },
        result: {
          [[4, 3, 2], [1, 0], []],
          [],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[4, 3, 2], [1, 0], []],
          items: [5],
          size: 3,
        },
        result: {
          [[5, 4, 3], [2, 1, 0], []],
          [],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[5, 4, 3], [2, 1, 0], []],
          items: [6],
          size: 3,
        },
        result: {
          [[6, 5, 4], [3, 2, 1], [0]],
          [],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[6, 5, 4], [3, 2, 1], [0]],
          items: [7],
          size: 3,
        },
        result: {
          [[7, 6, 5], [4, 3, 2], [1, 0]],
          [],
        },
      },
      %TestData{
        input: %TestInput{
          input: [[7, 6, 5], [4, 3, 2], [1, 0]],
          items: [8],
          size: 3,
        },
        result: {
          [[8, 7, 6], [5, 4, 3], [2, 1, 0]],
          [],
        },
      },
    ]

    def run() do
      Enum.map(@test_data, &test/1)
    end

    defp test(test_data = %TestData{
        input: %TestInput{
          input: input,
          items: items,
          size: size
        }
      }
    ) do
      result = Windows.push(input, items, size)
      passed = result == test_data.result
      %TestResult{test_data: test_data, result: result, passed: passed}
    end    
  end
end

defmodule SolutionTests do
  
end

# IO.puts("Failed tests:")
# WindowsTest.Tests.run()
# |> Enum.filter(&(!&1.passed))
# |> IO.inspect(charlists: :as_chars)


input = File.stream!("input1.txt")
#input = File.stream!("input2.txt")
solution = Day1.solve(input)
IO.inspect(solution)
output = solution <> "\n"
File.write!("output2.txt", output)
