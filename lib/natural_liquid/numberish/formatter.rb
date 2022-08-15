module Numberish
  module Formatter

    def self.format(number, opts)
      result = number
      result = number * 100 if opts[:percent] && number <= 1
      result = value(result, opts[:precision])
      result = Utils.number_to_words(result) if opts[:to_words]
      percent_sign = opts[:to_words] ? " percent" : "%"
      result = "#{result}#{percent_sign}" if opts[:percent]
      result.to_s
    end

    private

    def self.value(number, precision)
      if float?(number)
        precision ? number.round(precision) : number
      else
        number.to_i
      end
    end

    def self.float?(number)
      number % 1 != 0
    end

  end
end
