module Instructions
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
      raise ProgramEnd
    end)
  }

  class ProgramEnd < RuntimeError ; end
end
