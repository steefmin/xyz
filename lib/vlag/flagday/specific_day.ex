defmodule Vlag.Flagday.SpecificDay do
  alias Vlag.Flagday.FlagDay

  @date Date.new!(2022, 05, 06)
  # @date Date.utc_today()

  def is(%Date{} = date) do
    date
    |> FlagDay.is(__MODULE__)
  end

  def date_for_year(_year) do
    @date
  end

  def get_elements do
    MapSet.new([:raised])
  end

  def get_text do
    "Een specifieke dag"
  end
end
