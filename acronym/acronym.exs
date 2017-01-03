defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.replace(~r/[.,\/#!$%@\-\^&\*;:{}=_`~()]+/, " ")
    |> String.replace(~r/\s*(\p{Lu})/u, " \\1") 
    |> String.upcase
    |> String.trim
    |> String.split(~r/\s{1,}/)
    |> Enum.reduce("", fn(y, acc) -> acc <> String.first(y) end)
  end
end
