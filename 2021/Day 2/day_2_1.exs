defmodule Day2 do
  def solve(_input) do
    "x"
  end
end

result = File.stream!("input1.txt")
|> Day2.solve()
output = result <> "\n"
IO.write(output)
File.write!("output1.txt", output)
