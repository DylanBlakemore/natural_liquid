require "spec_helper"

RSpec.describe NaturalLiquid::SelectFilter do

  subject { Liquid::Template.parse(template).render(data) }
  let(:template) { "" }
  let(:data) { {} }

  describe "simple list" do
    let(:template) { "{{ fruits | select: name == 'pear' | join: \", \" }}"}
    let(:data) { { "fruits" => [{ "name" => "apple" }, { "name" => "pear" }, { "name" => "orange" }] } }

    it "lists the values in the array" do
      expect(subject).to eq("pear")
    end
  end
end
