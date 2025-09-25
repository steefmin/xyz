defmodule Vlag.Sun do
  @spec up?(DateTime.t()) :: boolean
  def up?(%DateTime{} = datetime) do
    datetime
    |> split_in_date_and_time()
    |> get_rise_and_set_of_date()
    |> determine_result()
  end

  defp split_in_date_and_time(datetime) do
    {DateTime.to_date(datetime), DateTime.to_time(datetime)}
  end

  defp get_rise_and_set_of_date({date, time}) do
    {lat, lng} = Vlag.Location.gps_coordinates()

    {:ok, rise_time} = Solarex.Sun.rise(date, lat, lng)
    {:ok, set_time} = Solarex.Sun.set(date, lat, lng)

    {date, time, apply_local_timezone(rise_time), apply_local_timezone(set_time)}
  end

  defp determine_result({_date, time, rise, set}) do
    case {Time.compare(time, rise), Time.compare(time, set)} do
      # before sunrise
      {:lt, _} -> false
      # after sunset
      {_, :gt} -> false
      # then must be between sunrise and sunset
      {_, _} -> true
    end
  end

  defp apply_local_timezone(naive_dt) do
    DateTime.from_naive!(naive_dt, "UTC")
    |> DateTime.shift_zone!(Vlag.Location.time_zone())
  end
end
