module Numberish
  class Hedge

    def self.phrase(hedge)
      Config.hedges[hedge].sample
    end

  end
end
