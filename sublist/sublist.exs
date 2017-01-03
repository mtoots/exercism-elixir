defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    a_len = length(a)
    b_len = length(b)

    case {a, b} do
      {[], []} -> :equal
      {[nil], []} -> :superlist
      {[], [nil]} -> :sublist  
      {a, a} -> :equal
      {a, b} when a_len < b_len -> 
        case sublist?(a, b) do
          true  -> :sublist
          false -> :unequal
        end
      {a, b} when a_len > b_len -> 
        case sublist?(b, a) do
          true  -> :superlist
          false -> :unequal
        end
      _ -> :unequal
    end
  end

  def _sublist?([], _) do
    true
  end

  def _sublist?([h1 | t1], [h2 | t2]) do
    cond do
      h1 === h2 -> _sublist?(t1, t2)
      true -> false
    end    
  end

  def sublist?(a, b) do
    index = Enum.find_index(b, &(&1 === hd(a)))

    cond do
      is_nil(index) -> false
      length(b) - index < length(a) -> false
      true -> 
        case _sublist?(tl(a), Enum.slice(b, index + 1, length(b) - index)) do
          true -> true
          false -> sublist?(a, Enum.slice(b, index + 1, length(b) - index))
        end
    end
  end
end
