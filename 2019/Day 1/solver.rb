module Solver
  def fuel_required(mass)
    # Computes the amount of fuel required to carry the given mass.
    [(mass / 3).floor - 2, 0].max
  end
  
  def total_fuel_required(base_mass)
    # Fuel has mass too. Computes the total number of fuel required to carry the
    # given mass AND the mass of the fuel itself.
    total_fuel = 0
    mass = base_mass.dup
    loop do
      fuel = fuel_required(mass)
      return total_fuel if fuel.zero?
      total_fuel += fuel
      mass = fuel.dup
    end
  end
  
  module_function(:fuel_required, :total_fuel_required)
end
