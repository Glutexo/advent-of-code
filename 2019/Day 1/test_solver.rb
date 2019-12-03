require('rspec-parameterized')
require_relative('solver')

describe('Solver::fuel_required') do
  where(:mass, :fuel) do
    [[12, 2], [14, 2], [1969, 654], [100756, 33583]]
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
