require('instructions')

module Solver
  def execute(intcode)
    i = 0
    loop do
      begin
        intcode, i = step(intcode, i)
      rescue Instructions::ProgramEnd
        return intcode
      end
    end
  end
  
  private
  
    def step(intcode, i)
      with_instruction(intcode, i) do |instruction, args|
        intcode = instruction.function.call(intcode, *args)
        i = i.succ + instruction.num_args
        return intcode, i
      end
    end
  
    def with_instruction(intcode, i)
      instruction = load_instruction(intcode, i)
      args = load_args(intcode, i, instruction.num_args)
      yield instruction, args
    end
    
    def load_instruction(intcode, i)
      instruction = intcode[i]
      raise RuntimeError unless Instructions::INSTRUCTIONS.has_key?(instruction)
      Instructions::INSTRUCTIONS[instruction]
    end
  
    def load_args(intcode, i, num_args)
      first = i + 1
      last = first + num_args
      intcode[first...last]
    end
  
  module_function(
    :execute, :step, :with_instruction, :load_instruction, :load_args
  )
end
