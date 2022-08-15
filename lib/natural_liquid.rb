# frozen_string_literal: true
require "liquid"

require_relative "natural_liquid/numberish/config"
require_relative "natural_liquid/numberish/formatter"
require_relative "natural_liquid/numberish/hedge"
require_relative "natural_liquid/numberish/approximation"
require_relative "natural_liquid/numberish/utils"

require_relative "natural_liquid/version"
require_relative "natural_liquid/text_filter"
require_relative "natural_liquid/list_filter"
require_relative "natural_liquid/number_filter"

module NaturalLiquid
  class Error < StandardError; end
end
