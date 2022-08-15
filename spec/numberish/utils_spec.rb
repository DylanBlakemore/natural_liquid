require "spec_helper"

RSpec.describe Numberish::Utils do

  describe ".number_to_words" do
    it "converts the number to words" do
      expect(described_class.number_to_words(1)).to eq("one")
      expect(described_class.number_to_words(2586)).to eq("two thousand five hundred and eighty six")
      expect(described_class.number_to_words(-53)).to eq("negative fifty three")
      expect(described_class.number_to_words(-53.4)).to eq("negative fifty three point four")
      expect(described_class.number_to_words(90.32)).to eq("ninety point three two")
    end

    it "does not convert a decimal if the only numbers after the decimal are zeros" do
      expect(described_class.number_to_words(5.000)).to eq("five")
    end
  end
end
