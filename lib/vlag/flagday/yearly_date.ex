defmodule Vlag.Flagday.YearlyDate do
  @type t :: %__MODULE__{
          month: integer,
          day: integer,
          alternative_day: integer,
          alternative_month: integer
        }

  defstruct(
    month: 0,
    day: 0,
    alternative_day: 0,
    alternative_month: 0
  )

  def date_for_year(flagday, year) when year |> is_integer() do
    Date.new!(year, flagday.month, flagday.day)
    |> use_alternative_day_when_day_falls_on_a_sunday(flagday)
  end

  defp use_alternative_day_when_day_falls_on_a_sunday(date, alt_day) do
    case Date.day_of_week(date) do
      7 -> Date.new!(date.year, alt_day.alternative_month, alt_day.alternative_day)
      _ -> date
    end
  end
end
