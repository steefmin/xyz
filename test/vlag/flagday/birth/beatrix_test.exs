defmodule Vlag.Flagday.Birth.BeatrixTest do
  use ExUnit.Case

  test "is/1 returns true for Princess Beatrix's birthday" do
    assert Vlag.Flagday.Birth.Beatrix.is(Date.new!(2024, 1, 31))
  end

  test "is/1 returns true for Princess Beatrix's birthday alternative date" do
    assert Vlag.Flagday.Birth.Beatrix.is(Date.new!(2027, 2, 1))
  end

  test "is/1 returns false for other dates" do
    refute Vlag.Flagday.Birth.Beatrix.is(Date.new!(2024, 1, 30))
    refute Vlag.Flagday.Birth.Beatrix.is(Date.new!(2024, 2, 2))
  end

  test "get_elements/0 returns the correct elements" do
    assert Vlag.Flagday.Birth.Beatrix.get_elements() == MapSet.new([:raised, :pennon])
  end

  test "get_text/0 returns a string" do
    assert is_binary(Vlag.Flagday.Birth.Beatrix.get_text())
  end
end
