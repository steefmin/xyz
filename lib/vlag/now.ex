defmodule Vlag.Now do
  def get do
    DateTime.now!(Vlag.Location.time_zone())
  end
end
