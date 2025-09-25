defmodule Vlag.Flagday.Birth.Maxima do
  alias Vlag.Flagday.FlagDay
  alias Vlag.Flagday.YearlyDate

  defstruct(
    month: 5,
    day: 17,
    alternative_day: 18,
    alternative_month: 5
  )

  defp construct do
    %__MODULE__{}
  end

  def is(%Date{} = date) do
    FlagDay.is(date, YearlyDate, construct())
  end

  def get_elements do
    MapSet.new([:raised, :pennon])
  end

  def get_text do
    "Verjaardag van Koningin Maxima"
  end
end
