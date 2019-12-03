#!/usr/bin/env ruby

require('solver')

sum = 0

$<.each_line do |line|
  mass = line.rstrip.to_i
  fuel = Solver::total_fuel_required(mass)
  sum += fuel
end

puts(sum)