module NaturalLiquid
  module SelectFilter

    def select(input, opts)
      binding.pry
    end

    private

  end
end

Liquid::Template.register_filter(NaturalLiquid::SelectFilter)
