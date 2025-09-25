defmodule Vlag.Flagday.RemembranceDay do
  alias Vlag.Flagday.FlagDay
  alias Vlag.Flagday.YearlyDate

  defstruct(
    month: 5,
    day: 4,
    alternative_day: 4,
    alternative_month: 5
  )

  defp construct do
    %__MODULE__{}
  end

  def is(%Date{} = date) do
    FlagDay.is(date, YearlyDate, construct())
  end

  def get_elements do
    MapSet.new([:half_raised, :wreath])
  end

  def get_text do
    "Dodenherdenking"
  end
end
