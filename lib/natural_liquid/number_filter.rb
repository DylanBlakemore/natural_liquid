module NaturalLiquid
  module NumberFilter

    def to_words(input)
      Numberish::Utils.number_to_words(input)
    end

    def approximate(input, opts={})
      Numberish::Approximation.to_words(input, **opts.symbolize_keys)
    end

  end
end

Liquid::Template.register_filter(NaturalLiquid::NumberFilter)
