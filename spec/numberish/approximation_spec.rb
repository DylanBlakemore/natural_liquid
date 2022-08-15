require "spec_helper"

RSpec.describe Numberish::Approximation do

  subject { described_class.new(actual_value, scale) }
  let(:actual_value) { 6.4 }
  let(:scale) { 5 }

  describe "#above" do
    it "returns the number above" do
      expect(subject.above).to eq(5)
    end

    context "with a decimal scale" do
      let(:scale) { 0.5 }

      it "returns the number above" do
        expect(subject.above).to eq(6)
      end
    end
  end

  describe "#below" do
    it "returns the number below" do
      expect(subject.below).to eq(10)
    end

    context "with a decimal scale" do
      let(:scale) { 0.5 }

      it "returns the number below" do
        expect(subject.below).to eq(6.5)
      end
    end
  end

  describe "around" do
    context "when the number is closer to the number above than the number below" do
      let(:actual_value) { 8.9 }
      it "returns the number above" do
        expect(subject.around).to eq(10)
        expect(subject.hedge).to eq(:less)
      end
    end

    context "when the number is closer to the number below than the number above" do
      it "returns the number below" do
        expect(subject.around).to eq(5)
        expect(subject.hedge).to eq(:more)
      end
    end
  end
end
