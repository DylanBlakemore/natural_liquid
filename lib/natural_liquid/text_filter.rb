require "indefinite_article"

module NaturalLiquid
  module TextFilter

    def with_indefinite_article(input)
      input&.with_indefinite_article
    end

  end
end

Liquid::Template.register_filter(NaturalLiquid::TextFilter)
