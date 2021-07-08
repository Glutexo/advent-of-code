defmodule AdventOfCode do
  @suffixes ["_example", ""]
  
  def main(args \\ []) do
    day_num = Enum.at(args, 0)
    run_day(day_num)
  end

  defp run_day(day) do
    run_fn = fn suffix -> run_day(day, suffix) end
    Enum.map(@suffixes, run_fn)
  end

  defp run_day(day, suffix) do
    file_name = "data/day_" <> day <> suffix <> ".txt"
    input = File.read!(file_name)
    mod = module(day)
    mod.solve(input) |> IO.puts()
  end

  defp module(day) do
    name = "Elixir.Day" <> day
    String.to_atom(name)
  end
end
