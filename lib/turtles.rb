require 'primitives'
module Turtles
  class Stack
    def initialize
      @stack = Word.NIL
    end

    def push word
      word.stack = stack
      @stack = word
    end

    def pop
      word = @stack
      @stack = word.stack
      word
    end
  end

  class Word
    extend Primitives
    attr :name, :body
    attr_accessor :stack

    def initialize name, body, stack
      @name = name
      @body = body
      self.stack = stack
    end

    class << self
      attr :NIL
      NIL = Word.new 'nil', nil, nil
    end
  end
end
