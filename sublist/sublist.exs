defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a == b -> :equal
      _subset?(a, b) -> :sublist
      _subset?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp _subset?([], _), do: true
  defp _subset?(_, []), do: false
  defp _subset?(a, b) do
    _starts_with?(a, b) || _subset?(a, tl(b))
  end

  defp _starts_with?([], _), do: true
  defp _starts_with?(_, []), do: false
  defp _starts_with?([x|xs], [y|ys]) do
    if x === y, do: _starts_with?(xs, ys)
  end
end
