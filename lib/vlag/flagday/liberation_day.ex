defmodule Vlag.Flagday.LiberationDay do
  alias Vlag.Flagday.FlagDay
  alias Vlag.Flagday.YearlyDate

  defstruct(
    month: 5,
    day: 5,
    alternative_day: 5,
    alternative_month: 5
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
    """
    Bevrijdingsdag is de Nederlandse nationale feestdag op 5 mei waarop jaarlijks de bevrijding van de Duitse bezetting in Nederland in 1945 wordt gevierd.
    Nederland staat op 5 mei ook stil bij de grote waarde van vrijheid, democratie en mensenrechten.
    """
  end
end
