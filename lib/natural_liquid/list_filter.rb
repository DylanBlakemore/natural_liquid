module NaturalLiquid
  module ListFilter

    def list(input, kwargs={})
      data = Liquid::StandardFilters::InputIterator.new(input, context).to_a
      join_list(data, kwargs["last_delimeter"])
        .then { |str| quantify(str, kwargs["quantify"], data.count) }
    end

    private

    def join_list(data, last_delimeter)
      if last_delimeter
        if data.count == 2
          "#{data[0]} #{last_delimeter} #{data[1]}"
        elsif data.count < 2
          data.join(", ")
        else
          "#{data[0..-2].join(", ")}, #{last_delimeter} #{data[-1]}" # Forced oxford comma, bitches
        end
      else
        data.join(", ")
      end
    end

    def quantify(value, type, count)
      case type
      when nil
        value
      when "positive"
        if count == 0
          value
        elsif count == 1
          "only #{value}"
        elsif count == 2
          "both #{value}"
        else
          "#{value} all"
        end
      when "negative"
        if count < 2
          value
        else
          "neither #{value}"
        end
      else
        raise ArgumentError, "quantifier type can only be positive or negative"
      end
    end

  end
end

Liquid::Template.register_filter(NaturalLiquid::ListFilter)
