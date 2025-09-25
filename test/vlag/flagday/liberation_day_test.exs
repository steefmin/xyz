defmodule Vlag.Flagday.LiberationDayTest do
  use ExUnit.Case

  test "is/1 returns true for Liberation Day" do
    assert Vlag.Flagday.LiberationDay.is(Date.new!(2024, 5, 5))
  end

  test "is/1 returns false for other dates" do
    refute Vlag.Flagday.LiberationDay.is(Date.new!(2024, 5, 4))
    refute Vlag.Flagday.LiberationDay.is(Date.new!(2024, 5, 6))
  end

  test "get_elements/0 returns the correct elements" do
    assert Vlag.Flagday.LiberationDay.get_elements() == MapSet.new([:raised])
  end

  test "get_text/0 returns a string" do
    assert is_binary(Vlag.Flagday.LiberationDay.get_text())
  end
end
