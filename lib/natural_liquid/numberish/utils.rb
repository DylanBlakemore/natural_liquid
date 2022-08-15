require "numbers_and_words"

module Numberish
  module Utils

    def self.number_to_words(number)
      return number unless numeric?(number)
      whole, fraction = split_decimal(number)
      negate(
        base_word(
          whole_word(whole),
          fraction_word(fraction)
        ),
        number
      )
    end

    private

    def self.negate(base, original)
      original < 0 ? "negative #{base}" : base
    end

    def self.base_word(whole, fraction)
      fraction ? "#{whole} point #{fraction}" : whole
    end

    def self.whole_word(whole)
      I18n.with_locale(:en) { whole&.abs&.to_words hundreds_with_union: true, remove_hyphen: true }
    end

    def self.fraction_word(fraction)
      fraction.to_s.split("").map(&:to_i).to_words.join(" ") if fraction && fraction > 0
    end

    def self.split_decimal(number)
      number.to_s.split(".").map(&:to_i)
    end

    def self.numeric?(number)
      Float(number, exception: false)
    end

  end
end
