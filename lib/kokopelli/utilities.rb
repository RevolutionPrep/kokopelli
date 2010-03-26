module Kokopelli
  module Utilities
    
    # Utility method for making passwords
    def choose_random_password(length=8)
      universe = (48..57).to_a+(65..90).to_a+(97..122).to_a
      (0...length).map {universe[Kernel.rand(universe.size)].chr}.join
    end
    
  end
end