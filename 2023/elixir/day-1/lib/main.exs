defmodule AoC do
  def find_digits(line) do
    digits = Enum.filter(line, fn ch -> ch in ?0..?9 end)
    first = List.first(digits) |> char_to_int
    last = List.last(digits) |> char_to_int
    combine_digits(first, last)
  end

  # 0 in ASCII
  @min_char_code 48

  def char_to_int(ch) do
    ch - @min_char_code
  end

  def combine_digits(a, b) do
    a * 10 + b
  end

  def to_digits(line) do
    line
    |> String.replace("eighthree", "83")
    |> String.replace("eightwo", "82")
    |> String.replace("fiveight", "58")
    |> String.replace("threeight", "38")
    |> String.replace("sevenine", "79")
    |> String.replace("oneight", "18")
    |> String.replace("twone", "21")
    |> String.replace("one", "1")
    |> String.replace("two", "2")
    |> String.replace("three", "3")
    |> String.replace("four", "4")
    |> String.replace("five", "5")
    |> String.replace("six", "6")
    |> String.replace("seven", "7")
    |> String.replace("eight", "8")
    |> String.replace("nine", "9")
    |> String.replace("zero", "0")

  end

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(fn x-> String.length(x) > 0 end)
  end
end

filename = "input.txt"

content = File.read!(filename)


total = AoC.parse_input(content)
  |> Enum.map(&AoC.to_digits/1)
  |> Enum.map(&String.to_charlist/1)
  |> Enum.reduce(0, fn line, acc ->
    digits = AoC.find_digits(line)
    acc + digits
  end)

IO.puts("Total: #{total}")
