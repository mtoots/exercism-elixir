defmodule RunLengthEncoder do
  import Enum, only: [map: 2, join: 1]
  import String, only: [to_integer: 1, duplicate: 2]

  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    Regex.scan(~r/(.)\1*/, string)
    |> map(&_compress/1)
    |> join
  end

  def _compress([match, char]) do
    to_string(String.length(match)) <> char
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    Regex.replace(
      ~r/(\d+)(\w)/,
      string,
      &_expand/3
    )
  end

  def _expand(_, n, letter) do
    duplicate(letter, to_integer(n))
  end
end
