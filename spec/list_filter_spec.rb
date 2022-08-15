require "spec_helper"

RSpec.describe NaturalLiquid::ListFilter do

  subject { Liquid::Template.parse(template).render(data) }
  let(:template) { "" }
  let(:data) { {} }

  describe "simple list" do
    let(:template) { "{{ fruits | list }}"}
    let(:data) { { "fruits" => ["apple", "pear", "orange"] } }

    it "lists the values in the array" do
      expect(subject).to eq("apple, pear, orange")
    end
  end

  describe "with a last separator" do
    let(:template) { "{{ fruits | list: last_delimeter: 'or' }}" }
    let(:data) { { "fruits" => ["apple", "pear", "orange"] } }

    it "adds the last separator" do
      expect(subject).to eq("apple, pear, or orange")
    end

    context "when there are only two elements" do
      let(:data) { { "fruits" => ["apple", "pear"] } }

      it "does not add the commas" do
        expect(subject).to eq("apple or pear")
      end
    end
  end

  describe "with a quantifier" do
    let(:template) { "{{ fruits | list: last_delimeter: 'and', quantify: 'positive' }}" }
    let(:data) { { "fruits" => ["apple", "pear", "orange"] } }

    context "when there is one element" do
      let(:data) { { "fruits" => ["apple"] } }

      it "adds 'only' onto the beginning of the string" do
        expect(subject).to eq("only apple")
      end
    end

    context "with a positive quantifier" do
      context "when there are two elements" do
        let(:data) { { "fruits" => ["apple", "pear"] } }

        it "adds 'both' onto the end of the string" do
          expect(subject).to eq("both apple and pear")
        end
      end

      context "when there are more than two elements" do
        it "adds 'all' onto the end of the string" do
          expect(subject).to eq("apple, pear, and orange all")
        end
      end

      context "when the filters are out of order" do
        let(:template) { "{{ fruits | list: quantify: 'positive', last_delimeter: 'and' }}" }

        it "works correctly" do
          expect(subject).to eq("apple, pear, and orange all")
        end
      end
    end
  end

  describe "map" do
    let(:template) { "{{ fruits | map: 'name' | list }}" }
    let(:data) { { "fruits" => [{ "name" => "apple" }, { "name" => "pear" }, { "name" => "orange" }] } }

    it "selects the correct variable" do
      expect(subject).to eq("apple, pear, orange")
    end

    context "with other options" do
      let(:template) { "{{ fruits | map: 'name' | list: quantify: 'positive', last_delimeter: 'and' }}" }

      it "works correctly" do
        expect(subject).to eq("apple, pear, and orange all")
      end
    end
  end

end
