defmodule AoC do
  # {int, string}
  def parse_game(line) do
    [label, sets_str] = String.split(line, ":", [trim: true])
    game_id = parse_label(label)

    { game_id, String.trim(sets_str)}
  end

  defp parse_label(label) do
    [_, id] = String.split(label, " ", [trim: true])

    String.to_integer(id)
  end
  # ["3 green, 2 red","2 blue"] 
  def parse_sets(sets_str) do
    String.split(sets_str, ";", [trim: true])
  end
  # [{quantity: int, label: red | green | blue}]
  def map_set(set) do
    cubes = String.split(set, ",", [trim: true])
    Enum.map(cubes, &parse_cubes/1)
  end

  # { quantity: int, label: red | green | blue }
  def parse_cubes(cubes) do
    [quantity, label] = String.split(cubes, " ", [trim: true])

    {String.to_integer(quantity), label}
  end

end

defmodule Part1 do
  def within_bounds?(limit) do
    fn cubes ->
      Enum.all?(Map.keys(limit), fn key -> Map.get(cubes, key) <= Map.get(limit, key)end )
    end
  end

  # cubes = [%{red, green, blue}]
  # [{id, cubes}]
  def main(games) do
    limit=%{ 
      "red" => 12,
      "green" => 13,
      "blue" => 14 
    }
    is_within_bounds? = Part1.within_bounds?(limit)
    games 
    |>Enum.filter(fn {_, list} ->Enum.all?(list, is_within_bounds?)end)
    |>Enum.reduce(0, fn { id, _ }, acc -> 
      acc + id
    end) 
  end
end

defmodule Part2 do
  # @type cubes :: %{red: int, green: int, blue: int}
  # @spec find_max(list(cubes)) :: cubes()
  defp find_max(list) do
    list
    |> Enum.reduce(%{ "red" => 0, "green" => 0, "blue" => 0 }, fn cube, acc ->
      Enum.reduce(Map.keys(cube), acc, fn key, acc -> 
        value = Map.get(cube, key)
        acc_value = Map.get(acc, key)
        Map.put(acc, key, max(acc_value, value))
      end)
    end)
  end

  # cubes = [%{red, green, blue}]
  # [{id, cubes}]
  def main(games) do
    games
    |> Enum.map(fn {_, cubes} -> 
      find_max(cubes)
    end)
    |>Enum.reduce(0, fn cubes, acc ->
      acc + Enum.reduce(Map.values(cubes), 1, &Kernel.*/2)
    end)
  end
end

{options, argv } = OptionParser.parse!(System.argv(), strict: [part: :integer])

filename=hd(argv)
part=options[:part]

content = File.read!(filename)



# cubes = [%{red, green, blue}]
# [{id, cubes}]
games = String.split(content, "\n", [trim: true])
  |> Enum.map(&AoC.parse_game/1)
  |> Enum.map(fn {id, sets} -> 
    cubes = sets
      |>AoC.parse_sets
      |>Enum.map(&AoC.map_set/1)
      |>Enum.map(fn sets -> 
        Enum.reduce(sets, %{"red" => 0, "green" => 0, "blue" => 0}, fn cube, acc -> 
          {quantity, label} = cube
          value = Map.get(acc, label)
          Map.put(acc, label, value + quantity)
        end)
      end)
    {id, cubes}
  end)

result = case part do
  1 -> Part1.main(games)
  2 -> Part2.main(games)
end



IO.puts("Result: #{inspect(result)}")
