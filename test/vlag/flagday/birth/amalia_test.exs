defmodule Vlag.Flagday.Birth.AmaliaTest do
  use ExUnit.Case

  test "is/1 returns true for Princess Amalia's birthday" do
    assert Vlag.Flagday.Birth.Amalia.is(Date.new!(2024, 12, 7))
  end

  test "is/1 returns true for Princess Amalia's birthday alternative date" do
    assert Vlag.Flagday.Birth.Amalia.is(Date.new!(2025, 12, 8))
  end

  test "is/1 returns false for other dates" do
    refute Vlag.Flagday.Birth.Amalia.is(Date.new!(2024, 12, 6))
    refute Vlag.Flagday.Birth.Amalia.is(Date.new!(2024, 12, 9))
  end

  test "get_elements/0 returns the correct elements" do
    assert Vlag.Flagday.Birth.Amalia.get_elements() == MapSet.new([:raised, :pennon])
  end

  test "get_text/0 returns a string" do
    assert is_binary(Vlag.Flagday.Birth.Amalia.get_text())
  end
end
