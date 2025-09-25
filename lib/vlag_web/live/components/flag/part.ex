defmodule VlagWeb.Live.Flag.Part do
  @wave_length 200

  # hardcode to 4 paths for now, used to be determined by the amount of visible waves + 1
  @paths 4

  @magic_a 0.36
  @magic_b 0.63

  def create(part_number, part_height, wave_height) do
    part_number
    |> create_starting_point(part_height, wave_height)
    |> add_positive_direction()
    |> add_vertical()
    |> add_negative_direction()
    |> close_shape()
  end

  defp create_starting_point(part_number, part_height, wave_height) do
    {part_number,
     "M0," <>
       ((part_number * part_height + animation_offset_y(wave_height)) |> Integer.to_string()),
     part_height, wave_height}
  end

  defp add_positive_direction({part_number, path, part_height, wave_height}) do
    path =
      [
        path,
        positive_down(part_number, 0, part_height, wave_height),
        positive_up(part_number, 1, part_height, wave_height),
        positive_down(part_number, 2, part_height, wave_height),
        positive_up(part_number, 3, part_height, wave_height)
      ]
      |> Enum.join(" ")

    {part_number, path, part_height, wave_height}
  end

  defp positive_down(part_number, element_number, part_height, wave_height) do
    create_curve(
      element_number * curve_length() + curve_length() * magic_a(),
      part_number * part_height + animation_offset_y(wave_height),
      element_number * curve_length() + curve_length() * magic_b(),
      wave_height + part_number * part_height + animation_offset_y(wave_height),
      (element_number + 1) * curve_length(),
      wave_height + part_number * part_height + animation_offset_y(wave_height)
    )
  end

  defp positive_up(part_number, element_number, part_height, wave_height) do
    create_curve(
      element_number * curve_length() + curve_length() * magic_a(),
      part_number * part_height + wave_height + animation_offset_y(wave_height),
      element_number * curve_length() + curve_length() * magic_b(),
      part_number * part_height + animation_offset_y(wave_height),
      (element_number + 1) * curve_length(),
      part_number * part_height + animation_offset_y(wave_height)
    )
  end

  defp add_vertical({part_number, path, part_height, wave_height}) do
    {part_number,
     "#{path} L#{(paths() * curve_length()) |> round()},#{((part_number + 1) * part_height + animation_offset_y(wave_height)) |> round()}",
     part_height, wave_height}
  end

  defp add_negative_direction({part_number, path, part_height, wave_height}) do
    path =
      [
        path,
        negative_down(part_number, 4, part_height, wave_height),
        negative_up(part_number, 3, part_height, wave_height),
        negative_down(part_number, 2, part_height, wave_height),
        negative_up(part_number, 1, part_height, wave_height)
      ]
      |> Enum.join(" ")

    {part_number, path}
  end

  defp negative_down(part_number, element_number, part_height, wave_height) do
    create_curve(
      (element_number - 1) * curve_length() + curve_length() * magic_b(),
      (part_number + 1) * part_height + animation_offset_y(wave_height),
      (element_number - 1) * curve_length() + curve_length() * magic_a(),
      (part_number + 1) * part_height + wave_height + animation_offset_y(wave_height),
      (element_number - 1) * curve_length(),
      (part_number + 1) * part_height + animation_offset_y(wave_height) + wave_height
    )
  end

  defp negative_up(part_number, element_number, part_height, wave_height) do
    create_curve(
      (element_number - 1) * curve_length() + curve_length() * magic_b(),
      (part_number + 1) * part_height + animation_offset_y(wave_height) + wave_height,
      (element_number - 1) * curve_length() + curve_length() * magic_a(),
      (part_number + 1) * part_height + animation_offset_y(wave_height),
      (element_number - 1) * curve_length(),
      (part_number + 1) * part_height + animation_offset_y(wave_height)
    )
  end

  defp close_shape({_, path}) do
    "#{path} Z"
  end

  defp create_curve(a, b, c, d, e, f) do
    path =
      [
        "#{a |> round()},#{b |> round()}",
        "#{c |> round()},#{d |> round()}",
        "#{e |> round()},#{f |> round()}"
      ]
      |> Enum.join(",")

    "C#{path}"
  end

  defp curve_length do
    @wave_length / 2
  end

  defp animation_offset_y(wave_height) do
    wave_height
  end

  defp magic_a do
    @magic_a
  end

  defp magic_b do
    @magic_b
  end

  defp paths do
    @paths
  end
end
