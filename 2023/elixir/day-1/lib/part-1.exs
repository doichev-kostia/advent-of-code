filename = "input.txt"

content = File.read!(filename)
lines = String.split(content, "\n")
min_char_code = 48
max_char_code = 57

is_char_number = fn ch -> ch >= min_char_code && ch <= max_char_code end
to_int = fn x -> x - 48 end

total =
  Enum.filter(lines, fn x -> String.length(x) > 0 end)
  |> Enum.reduce(0, fn line, acc ->
    charlist = String.to_charlist(line)
    first = Enum.find(charlist, is_char_number)
    last = Enum.find(Enum.reverse(charlist), is_char_number)

    acc + to_int.(first) * 10 + to_int.(last)
  end)

IO.puts("Total: #{total}")
