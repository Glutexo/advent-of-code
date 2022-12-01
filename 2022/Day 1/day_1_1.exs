defmodule Day1 do
  def solve(input) do
    input
	|> Enum.map(&String.trim_trailing/1)
	|> split_by_groups()
	|> Enum.map(&numerize_group/1)
	|> Enum.map(&Enum.sum/1)
	|> Enum.max()
#	|> Enum.join("\n")
  end

  defp split_by_groups(strings) do
    no_groups = []
    Enum.reduce(strings, no_groups, &split_by_groups_reduce/2)
  end

  defp split_by_groups_reduce("", acc) do
    add_group(acc)
  end

  defp split_by_groups_reduce(element, empty_acc = []) do
    acc_first_group = add_group(empty_acc)
    split_by_groups_reduce(element, acc_first_group)
  end

  defp split_by_groups_reduce(element, [current | complete]) do
    [[element | current] | complete]
  end

  defp add_group(groups) do
    [[] | groups]
  end

  defp numerize_group(group) do
    Enum.map(group, &String.to_integer/1)
  end
end

input = File.stream!("input2.txt")
result = Day1.solve(input)
output = Integer.to_string(result) <> "\n"
File.write!("output2.txt", output)
#IO.inspect(output)
#IO.puts(output)