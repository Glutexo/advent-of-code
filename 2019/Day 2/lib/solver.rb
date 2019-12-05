module Solver
  INSTRUCTIONS = {
    1 => lambda do |input, cur_i|
      with_args(input, cur_i, 3) do |output, x1_i, x2_i, target_i|
        output[target_i] = input[x1_i] + input[x2_i]
      end
    end,
    2 => lambda do |input, cur_i|
      with_args(input, cur_i, 3) do |output, x1_i, x2_i, target_i|
        output[target_i] = input[x1_i] * input[x2_i]
      end
    end,
    99 => lambda do |input, cur_i|
      return input, input.length
    end
  }
  
  def execute(intcode)
    i = 0
    while i < intcode.length do
      instruction = intcode[i]
      raise RuntimeError unless INSTRUCTIONS.has_key?(instruction)
      intcode, i = INSTRUCTIONS[instruction].call(intcode, i)
    end
    intcode
  end
  
  private
  def with_args(input, index, count)
    output = input.dup
    
    first = index + 1
    last = index + count
    yield output, *input[first..last]
    
    return output, first + count
  end
  
  module_function(:execute, :with_args)
end
