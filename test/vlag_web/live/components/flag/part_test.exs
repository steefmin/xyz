defmodule SteefMinWeb.Live.Flag.PartTest do
  use ExUnit.Case

  alias SteefMinWeb.Live.Flag.Part

  test "builds correct path" do
    assert "M0,20 C36,20,63,40,100,40 C136,40,163,20,200,20 C236,20,263,40,300,40 C336,40,363,20,400,20 L400,40 C363,40,336,60,300,60 C263,60,236,40,200,40 C163,40,136,60,100,60 C63,60,36,40,0,40 Z" ===
             Part.create(0, 20, 20)
  end
end
