#!/usr/bin/env ruby

require('solver')

output = nil

$<.each_line do |line|
  original_input = line.split(',').map(&:to_i)
  
  patched_input = original_input.dup
  patched_input[1] = 12
  patched_input[2] = 2
  
  output = Solver::execute(patched_input)
end

puts(output[0])
