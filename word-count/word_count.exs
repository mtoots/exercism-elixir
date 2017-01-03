defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    String.downcase(sentence) #To lower case
    |> String.replace(~r/[.,\/#!$%@\^&\*;:{}=_`~()]+/, " ") # replace punctuation with " "
    |> String.trim # trim whitespace
    |> String.split(~r/\s{1,}/) # split the string
    |> Enum.group_by(&(&1)) # group by word. returns a map
    |> Enum.map(fn {k, v} -> {k, length(v)} end) #Map values to length
    |> Map.new #Convert into map
  end
end
