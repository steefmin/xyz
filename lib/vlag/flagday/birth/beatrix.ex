defmodule Vlag.Flagday.Birth.Beatrix do
  alias Vlag.Flagday.FlagDay
  alias Vlag.Flagday.YearlyDate

  defstruct(
    month: 1,
    day: 31,
    alternative_day: 1,
    alternative_month: 2
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
    "Hare Koninklijke Hoogheid Prinses Beatrix was 33 jaar Koningin der Nederlanden, van 1980 tot 2013. Op 30 april 2013 werd Prinses Beatrix opgevolgd door haar oudste zoon Willem-Alexander. Vandaag vieren we haar verjaardag."
  end
end
