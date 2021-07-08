defmodule AdventOfCode do
  @suffixes ["_example", ""]
  
  def main(args \\ []) do
    Enum.at(args, 0) |> run_day()
  end

  defp run_day(day) do
    Enum.map(@suffixes, fn suffix -> run_day(day, suffix) end)    
  end

  defp run_day(day, suffix) do
    input = "data/day_" <> day <> suffix <> ".txt" |> File.read!()
    module(day).solve(input) |> IO.puts 
 end

  defp module(day) do
    "Elixir.Day" <> day |> String.to_atom()
  end
end
