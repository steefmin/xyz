defmodule Vlag.Flagday.KingdomDay do
  alias Vlag.Flagday.FlagDay
  alias Vlag.Flagday.YearlyDate

  defstruct(
    month: 12,
    day: 15,
    alternative_day: 16,
    alternative_month: 12
  )

  defp construct do
    %__MODULE__{}
  end

  def is(%Date{} = date) do
    FlagDay.is(date, YearlyDate, construct())
  end

  def get_elements do
    MapSet.new([:raised])
  end

  def get_text do
    "Vandaag vlaggen we voor Koninkrijksdag. Op deze dag wordt herdacht dat Koningin Juliana in 1954 het Statuut voor het Koninkrijk der Nederlanden in de Ridderzaal tekende. Het Koninkrijk der Nederlanden bestond toen uit Nederland, Suriname en de Nederlandse Antillen."
  end
end
