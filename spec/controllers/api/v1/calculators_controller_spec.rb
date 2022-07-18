require "rails_helper"

RSpec.describe Api::V1::CalculatorsController, type: :controller do
  let(:base_params) {
    {
      property_price: 500000,
      term: 30,
      down_payment: 100000,
      credit_score: credit_worth,
    }
  }

  describe "calculate mortgage" do
    context "with worthy credit" do
      let!(:credit_worth) { 700 }
      it "returns total_loan and montly_payments" do
        post :create, params: base_params

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)).to eq({ "monthly_payment" => 2377.67, "total_loan" => 855961.20 })
      end
    end

    context "with poor credit" do
      let!(:credit_worth) { 400 }
      it "returns error message" do
        post :create, params: base_params
        expect(response).to have_http_status(:no_content)
        expect(JSON.parse(response.body)).to eq("error" => "unfortunately your credit needs improvement before you are eligible for a mortgage")
      end
    end
  end
end
