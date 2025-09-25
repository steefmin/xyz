defmodule Vlag.Flagday.FlagDay do
  def is(%Date{} = date, cb, day_data) do
    cb.date_for_year(day_data, date.year)
    |> equals(date)
  end

  def is(%Date{} = date, cb) do
    cb.date_for_year(date.year)
    |> equals(date)
  end

  defp equals(flag_date, current_date) do
    Date.compare(flag_date, current_date) === :eq
  end
end
