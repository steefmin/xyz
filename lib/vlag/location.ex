defmodule Vlag.Location do
  @gps_coordinates {52.155170, 5.387200}

  @timezone "Europe/Amsterdam"

  def gps_coordinates do
    @gps_coordinates
  end

  def time_zone do
    @timezone
  end
end
