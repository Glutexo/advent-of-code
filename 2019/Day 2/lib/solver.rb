module Solver
  Instruction = Struct.new(:num_args, :function)
  
  INSTRUCTIONS = {
    1 => Instruction.new(3, lambda do |input, x1_i, x2_i, target_i|
      output = input.dup
      output[target_i] = input[x1_i] + input[x2_i]
      output
    end),
    2 => Instruction.new(3, lambda do |input, x1_i, x2_i, target_i|
      output = input.dup
      output[target_i] = input[x1_i] * input[x2_i]
      output
    end),
    99 => Instruction.new(0, lambda do |input|
      return nil
    end)
  }
  
  def execute(intcode)
    i = 0
    while i < intcode.length do
      instruction_code = intcode[i]
      raise RuntimeError unless INSTRUCTIONS.has_key?(instruction_code)
      
      instruction = INSTRUCTIONS[instruction_code]
      
      i = i.succ
      args = intcode[i...i + instruction.num_args]
      result = instruction.function.call(intcode, *args)
      result ? intcode = result : break
      
      i += instruction.num_args
    end
    intcode
  end
  
  module_function(:execute)
end
