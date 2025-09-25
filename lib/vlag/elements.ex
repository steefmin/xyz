defmodule Vlag.Elements do
  alias Vlag.Flagday.Resolver

  def wreath?(%DateTime{} = datetime) do
    flag_day_has?(datetime, :wreath) && Vlag.Sun.up?(datetime)
  end

  def pennon?(%DateTime{} = datetime) do
    flag_day_has?(datetime, :pennon) && Vlag.Sun.up?(datetime)
  end

  def flag_raised?(%DateTime{} = datetime) do
    flag_day_has?(datetime, :raised) && Vlag.Sun.up?(datetime)
  end

  def flag_half_raised?(%DateTime{} = datetime) do
    flag_day_has?(datetime, :half_raised) && Vlag.Sun.up?(datetime)
  end

  def description(%DateTime{} = datetime) do
    datetime
    |> DateTime.to_date()
    |> get_text()
  end

  defp flag_day_has?(%DateTime{} = datetime, element) do
    datetime
    |> DateTime.to_date()
    |> get_elements()
    |> MapSet.member?(element)
  end

  defp get_elements(%Date{} = date) do
    Resolver.is(date)
    |> case do
      {:no_flag_day, _date} -> MapSet.new()
      {day, _date} -> day.get_elements()
    end
  end

  defp get_text(%Date{} = date) do
    Resolver.is(date)
    |> case do
      {:no_flag_day, _date} -> "Er is vandaag geen reden om de vlag te voeren."
      {day, _date} -> day.get_text()
    end
  end
end
