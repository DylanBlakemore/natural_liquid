module Numberish
  class Approximation

    def self.to_words(number, scale: nil, hedge: nil, **formatter_opts)
      approx = Approximation.new(number, scale, hedge&.to_sym)
      approx.phrase(formatter_opts)
    end

    attr_reader :actual_value, :scale

    def initialize(actual_value, scale=nil, hedge=nil)
      @actual_value = actual_value
      @scale = scale || infer_scale(actual_value)
      @hedge = hedge
    end

    def equal?
      actual_value % scale == 0
    end

    def below
      @below ||= above + scale
    end

    def above
      @above ||= actual_value - (actual_value % scale)
    end

    def around
      @around ||= distance_to_below < distance_to_above ? below : above
    end

    def value
      return actual_value if equal?
      return below if hedge == :less
      return above if hedge == :more
      return around
    end

    def hedge
      return :equal if equal?
      return @hedge if @hedge
      distance_to_below < distance_to_above ? :less : :more
    end

    def phrase(formatter_opts={})
      hedge_phrase = Hedge.phrase(hedge)
      if hedge_phrase.present?
        "#{hedge_phrase} #{Formatter.format(value, formatter_opts)}"
      else
        "#{Formatter.format(value, formatter_opts)}"
      end
    end

    private

    def infer_scale(number)
      return 0.05 if number < 1
      return 0.5 if number <= 5
      return 1 if number <= 30
      return 5 if number <= 200
      return 10 if number <= 1000
      return 100
    end

    def distance_to_below
      @distance_to_below ||= below - actual_value
    end

    def distance_to_above
      @distance_to_above ||= actual_value - above
    end

  end
end
