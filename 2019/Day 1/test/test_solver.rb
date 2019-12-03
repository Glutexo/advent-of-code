require('rspec-parameterized')
require('solver')

describe('Solver::fuel_required') do
  where(:mass, :fuel) do
    [
      # Canonical examples from the Part One
      [12, 2], [14, 2], [1969, 654], [100756, 33583],
      # Additional examples based on the Part Two extension
      [6, 0], [7, 0], [3, 0], [2, 0]
    ]
  end

  subject do
    Solver::fuel_required(mass)
  end
  
  with_them do
    it('computes correctly') do
      is_expected.to(eq(fuel))
    end
  end
end

describe('Solver::total_fuel_required') do
  where(:mass, :fuel) do
    [
      # Canonical examples from the Part Two
      [14, 2], [1969, 966], [100756, 50346] 
    ]
  end

  subject do
    Solver::total_fuel_required(mass)
  end

  with_them do
    it('computes correctly') do
      is_expected.to(eq(fuel))
    end
  end
end