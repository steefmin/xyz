defmodule Vlag.Flagday.KingdomDayTest do
  use ExUnit.Case

  test "is/1 returns true for Kingdom Day" do
    assert Vlag.Flagday.KingdomDay.is(Date.new!(2024, 12, 16))
  end

  test "is/1 returns false for other dates" do
    refute Vlag.Flagday.KingdomDay.is(Date.new!(2024, 12, 14))
    assert Vlag.Flagday.KingdomDay.is(Date.new!(2024, 12, 16))
    refute Vlag.Flagday.KingdomDay.is(Date.new!(2024, 12, 17))
  end

  test "get_elements/0 returns the correct elements" do
    assert Vlag.Flagday.KingdomDay.get_elements() == MapSet.new([:raised])
  end

  test "get_text/0 returns a string" do
    assert is_binary(Vlag.Flagday.KingdomDay.get_text())
  end
end
