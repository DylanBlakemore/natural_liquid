require "spec_helper"

RSpec.describe NaturalLiquid::TextFilter do
  describe "#with_indefinite_article" do
    let(:template) { Liquid::Template.parse("{{ text | with_indefinite_article }}") }

    it "adds the correct indefinite article" do
      expect(template.render({ "text" => "apple" })).to eq("an apple")
      expect(template.render({ "text" => "banana" })).to eq("a banana")
      expect(template.render({ "text" => "hour" })).to eq("an hour")
      expect(template.render({ "text" => "university" })).to eq("a university")
    end
  end
end
