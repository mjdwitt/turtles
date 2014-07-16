def stack_eval input
  input.inject([]) do |stack, token|
    begin
      stack.push Integer(token)
    rescue ArgumentError
      arg = stack.pop
      rec = stack.pop
      op = token.to_sym
      stack.push rec.send(op, arg)
    end
  end.pop
rescue NoMethodError, TypeError, ArgumentError
  raise TurtleError.new("!!")
end

class TurtleError < StandardError
end

def main
  while input = gets
    begin 
      puts "=> #{stack_eval input.split(/\s/)}"
    rescue TurtleError => e
      puts "Error: #{e.to_s}"
    end
  end
  puts 'bye!'
end

main
