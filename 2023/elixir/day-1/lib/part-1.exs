filename = "input.txt"

content = File.read!(filename)
lines = String.split(content, "\n")
# 0
min_char_code = 48
# 9
max_char_code = 57

is_char_number = fn ch -> ch >= min_char_code && ch <= max_char_code end
to_int = fn x -> x - min_char_code end

total =
  Enum.filter(lines, fn x -> String.length(x) > 0 end)
  |> Enum.reduce(0, fn line, acc ->
    charlist = String.to_charlist(line)
    first = Enum.find(charlist, is_char_number)
    last = Enum.find(Enum.reverse(charlist), is_char_number)

    # the task is to combine the numbers, we can do that by moving the first number to the next rank
    # In decimal the next rank is x * 10
    acc + to_int.(first) * 10 + to_int.(last)
  end)

IO.puts("Total: #{total}")
