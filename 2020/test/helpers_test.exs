defmodule HelpersTest do
  use ExUnit.Case

  test "one combination" do
    assert Helpers.combinations([1, 2]) == [{1, 2}]
  end
end
