defmodule Vlag.Flagday.Resolver do
  @days [
    Vlag.Flagday.Kingsday,
    Vlag.Flagday.RemembranceDay,
    Vlag.Flagday.LiberationDay,
    Vlag.Flagday.VeteransDay,
    Vlag.Flagday.EndOfWW2,
    Vlag.Flagday.PrinceDay,
    Vlag.Flagday.KingdomDay,
    Vlag.Flagday.Birth.Amalia,
    Vlag.Flagday.Birth.Beatrix,
    Vlag.Flagday.Birth.Maxima,
    Vlag.Flagday.SpecificDay
  ]

  def is(%Date{} = date) do
    Enum.reduce_while(@days, date, fn value, acc -> reduce(value, acc) end)
    |> return_result()
  end

  defp reduce(day, date) do
    if day.is(date), do: {:halt, {day, date}}, else: {:cont, date}
  end

  defp return_result(%Date{} = date) do
    {:no_flag_day, date}
  end

  defp return_result({_, %Date{}} = res) do
    res
  end
end
