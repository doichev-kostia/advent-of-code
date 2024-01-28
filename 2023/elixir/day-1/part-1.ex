filename="input.example.txt"

case File.read(filename, [:utf8]) do
  {:ok, body} -> IO.puts(body)
  {:error, reason} -> IO.puts(reason)
end


