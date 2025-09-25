defmodule Vlag.Flagday.PrinceDayTest do
  use ExUnit.Case

  test "date_for_year/1 returns the correct date for 2024" do
    assert Vlag.Flagday.PrinceDay.date_for_year(2024) == Date.new!(2024, 9, 17)
  end

  test "is/1 returns true for Prince Day" do
    assert Vlag.Flagday.PrinceDay.is(Date.new!(2024, 9, 17))
  end

  test "is/1 returns false for other dates" do
    refute Vlag.Flagday.PrinceDay.is(Date.new!(2024, 9, 16))
    refute Vlag.Flagday.PrinceDay.is(Date.new!(2024, 9, 18))
  end

  test "get_elements/0 returns the correct elements" do
    assert Vlag.Flagday.PrinceDay.get_elements() == MapSet.new([:raised])
  end

  test "get_text/0 returns a string" do
    assert is_binary(Vlag.Flagday.PrinceDay.get_text())
  end
end
