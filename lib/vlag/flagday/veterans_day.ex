defmodule Vlag.Flagday.VeteransDay do
  alias Vlag.Flagday.FlagDay

  @month 6
  @last_day_of_month 30
  @saturday 6

  def is(%Date{} = date) do
    FlagDay.is(date, __MODULE__)
  end

  def date_for_year(year) do
    Date.range(first_day(year), last_day(year))
    |> Enum.filter(fn date -> date |> Date.day_of_week() == @saturday end)
    |> List.last()
  end

  defp first_day(year) do
    Date.new!(year, @month, 1)
  end

  defp last_day(year) do
    Date.new!(year, @month, @last_day_of_month)
  end

  def get_elements do
    MapSet.new([:raised])
  end

  def get_text do
    "Veteranendag"
  end
end
