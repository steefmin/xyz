defmodule Vlag.Flagday.KingsdayTest do
  use ExUnit.Case

  test "is/1 returns true for Kingsday" do
    assert Vlag.Flagday.Kingsday.is(Date.new!(2024, 4, 27))
  end

  test "is/1 returns false for other dates" do
    refute Vlag.Flagday.Kingsday.is(Date.new!(2024, 4, 28))
  end

  test "get_elements/0 returns the correct elements" do
    assert Vlag.Flagday.Kingsday.get_elements() == MapSet.new([:raised, :pennon])
  end

  test "get_text/0 returns a string" do
    assert is_binary(Vlag.Flagday.Kingsday.get_text())
  end

  test "is/1 returns true for 2025 Kingsday" do
    assert Vlag.Flagday.Kingsday.is(Date.new!(2025, 4, 26))
  end

  test "is/1 returns false for the 27th of April in 2025" do
    refute Vlag.Flagday.Kingsday.is(Date.new!(2025, 4, 27))
  end
end
