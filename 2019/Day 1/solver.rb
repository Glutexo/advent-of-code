module Solver
  def fuel_required(mass)
    (mass / 3).floor - 2
  end
  
  module_function(:fuel_required)
end
