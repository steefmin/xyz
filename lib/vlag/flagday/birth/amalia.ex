defmodule Vlag.Flagday.Birth.Amalia do
  alias Vlag.Flagday.FlagDay
  alias Vlag.Flagday.YearlyDate

  defstruct(
    month: 12,
    day: 7,
    alternative_day: 8,
    alternative_month: 12
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
    "Hare Koninklijke Hoogheid Prinses Catharina-Amalia der Nederlanden viert op 7 december haar verjaardag."
  end
end
