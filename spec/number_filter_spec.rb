require "spec_helper"

RSpec.describe NaturalLiquid::NumberFilter do
  describe "#to_words" do
    let(:template) { Liquid::Template.parse("{{ number | to_words }}") }

    it "converts the number to words" do
      expect(template.render({ "number" => 1 })).to eq("one")
      expect(template.render({ "number" => 2586 })).to eq("two thousand five hundred and eighty six")
      expect(template.render({ "number" => -53 })).to eq("negative fifty three")
      expect(template.render({ "number" => -53.4 })).to eq("negative fifty three point four")
      expect(template.render({ "number" => 90.32 })).to eq("ninety point three two")
    end
  end

  describe "#to_approximate_words" do
    let(:numberish_data) do
      {
        en: {
          hedges: {
            equal: [""],
            around: ["about"],
            more: ["over"],
            less: ["nearly"]
          }
        }
      }
    end

    before { Numberish::Config.data = numberish_data }

    let(:template) { Liquid::Template.parse("{{ number | approximate }}") }

    it "converts the number to an approximate string" do
      expect(template.render({ "number" => 1.76 })).to eq("nearly 2")
      expect(template.render({ "number" => 1.54 })).to eq("over 1.5")
      expect(template.render({ "number" => 1.5 })).to eq("1.5")
    end

    context "with a scale defined" do
      let(:template) { Liquid::Template.parse("{{ number | approximate: scale: 5 }}") }

      it "uses the scale" do
        expect(template.render({ "number" => 6.4 })).to eq("over 5")
        expect(template.render({ "number" => 8.3 })).to eq("nearly 10")
      end
    end

    context "with a hedge defined" do
      let(:template) { Liquid::Template.parse("{{ number | approximate: scale: 5, hedge: 'around' }}") }

      it "uses the hedge" do
        expect(template.render({ "number" => 6.4 })).to eq("about 5")
      end
    end

    context "with formatter opts" do
      let(:template) { Liquid::Template.parse("{{ number | approximate: to_words: true }}") }

      it "formats the result correctly" do
        expect(template.render({ "number" => 76 })).to eq("over seventy five")
      end
    end

    context "with percentages" do
      let(:template) { Liquid::Template.parse("{{ number | approximate: to_words: true, percent: true }}") }

      it "formats the result correctly" do
        expect(template.render({ "number" => 0.76 })).to eq("over seventy five percent")
      end
    end
  end
end
