defmodule Vlag.Flagday.Kingsday do
  alias Vlag.Flagday.FlagDay
  alias Vlag.Flagday.YearlyDate

  defstruct(
    month: 4,
    day: 27,
    alternative_day: 26,
    alternative_month: 4
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
    "Koningsdag is de nationale feestdag waarop de verjaardag van de Koning wordt gevierd."
  end
end
