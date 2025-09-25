defmodule Vlag.Flagday.RemembranceDayTest do
  use ExUnit.Case

  test "is/1 returns true for Remembrance Day" do
    assert Vlag.Flagday.RemembranceDay.is(Date.new!(2024, 5, 4))
  end

  test "is/1 returns false for other dates" do
    refute Vlag.Flagday.RemembranceDay.is(Date.new!(2024, 5, 3))
    refute Vlag.Flagday.RemembranceDay.is(Date.new!(2024, 5, 5))
  end

  test "get_elements/0 returns the correct elements" do
    assert Vlag.Flagday.RemembranceDay.get_elements() == MapSet.new([:half_raised, :wreath])
  end

  test "get_text/0 returns a string" do
    assert is_binary(Vlag.Flagday.RemembranceDay.get_text())
  end
end
