defmodule Vlag.Flagday.PrinceDay do
  alias Vlag.Flagday.FlagDay

  @month 9
  @last_day_of_month 30
  @tuesday 2

  def is(%Date{} = date) do
    date
    |> FlagDay.is(__MODULE__)
  end

  def date_for_year(year) do
    Date.range(first_day(year), last_day(year))
    |> Enum.filter(fn date -> date |> Date.day_of_week() == @tuesday end)
    |> Enum.fetch!(2)
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
    "Prinsjesdag"
  end
end
