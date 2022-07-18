require "rails_helper"

RSpec.describe Rates, type: :service do
  describe "#rates" do
    it "returns rate based on okay or higher score" do
      expect(Rates.rates(699.1)).to eq(4.0)
    end
    it "returns nil when poor credit score" do
      expect(Rates.rates(599)).to be_nil
    end
  end

  describe "#credit_score" do
    it "returns rating" do
      expect(Rates.credit_score(800)).to eq("excellent credit")
    end
  end
end
