defmodule Vlag.Flagday.EndOfWW2 do
  alias Vlag.Flagday.FlagDay
  alias Vlag.Flagday.YearlyDate

  defstruct(
    month: 8,
    day: 15,
    alternative_day: 16,
    alternative_month: 8
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
    "Voor het Koninkrijk der Nederlanden kwam er op 15 augustus 1945 officieel een einde aan de Tweede Wereldoorlog. "
  end
end
