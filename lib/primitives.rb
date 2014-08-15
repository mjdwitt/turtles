module Primitives
  def primitive? word
    true if Integer(word)
  rescue ArgumentError
    true if PRIMITIVE_WORDS.include? word
  end
end
