module Api
  module V1
    class CalculatorsController < ApplicationController
      def create
        calculate = Calculator.new(*base_params)
        @monthly_payment = calculate.monthly_payment
        @total_loan = calculate.total_interest(params[:term].to_i, @monthly_payment)
        if @total_loan.is_a?(Numeric)
          render [{ 'total_loan': @total_loan, 'monthly_payment': @monthly_payment }], status: 201
        else
          render [{ 'error': @total_loan }], status: 204
        end
      end

      def base_params
        params.permit(:property_price, :term, :down_payment, :credit_score)
      end
    end
  end
end
