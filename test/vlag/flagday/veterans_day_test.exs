defmodule Vlag.Flagday.VeteransDayTest do
  use ExUnit.Case

  test "date_for_year/1 returns the correct date for 2024" do
    assert Vlag.Flagday.VeteransDay.date_for_year(2024) == Date.new!(2024, 6, 29)
  end

  test "is/1 returns true for Veterans Day" do
    assert Vlag.Flagday.VeteransDay.is(Date.new!(2024, 6, 29))
  end

  test "is/1 returns false for other dates" do
    refute Vlag.Flagday.VeteransDay.is(Date.new!(2024, 6, 28))
    refute Vlag.Flagday.VeteransDay.is(Date.new!(2024, 6, 30))
  end

  test "get_elements/0 returns the correct elements" do
    assert Vlag.Flagday.VeteransDay.get_elements() == MapSet.new([:raised])
  end

  test "get_text/0 returns a string" do
    assert is_binary(Vlag.Flagday.VeteransDay.get_text())
  end
end
