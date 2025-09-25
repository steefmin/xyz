defmodule Vlag.Flagday.Birth.MaximaTest do
  use ExUnit.Case

  test "is/1 returns true for Queen Maxima's birthday" do
    assert Vlag.Flagday.Birth.Maxima.is(Date.new!(2024, 5, 17))
  end

  test "is/1 returns true for Queen Maxima's birthday alternative date" do
    assert Vlag.Flagday.Birth.Maxima.is(Date.new!(2009, 5, 18))
  end

  test "is/1 returns false for other dates" do
    refute Vlag.Flagday.Birth.Maxima.is(Date.new!(2024, 5, 16))
    refute Vlag.Flagday.Birth.Maxima.is(Date.new!(2024, 5, 19))
  end

  test "get_elements/0 returns the correct elements" do
    assert Vlag.Flagday.Birth.Maxima.get_elements() == MapSet.new([:raised, :pennon])
  end

  test "get_text/0 returns a string" do
    assert is_binary(Vlag.Flagday.Birth.Maxima.get_text())
  end
end
