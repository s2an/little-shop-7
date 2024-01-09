require 'rails_helper'
require 'helper_methods'

RSpec.describe Merchant, type: :model do
  describe "associations" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "methods" do
    it "finds item ids for a given merchant" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_1.id)
      item_3 = create(:item, merchant_id: merchant_2.id)
      item_4 = create(:item, merchant_id: merchant_2.id)
      
      expect(merchant_1.item_ids).to eq([item_1.id, item_2.id])
      expect(merchant_2.item_ids).to eq([item_3.id, item_4.id])
    end
  describe "instance methods" do
    describe "#top_five_customers (User Story 3)" do
      # As a merchant,
      # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
      # Then I see the names of the top 5 customers
      # who have conducted the largest number of successful transactions with my merchant
      # And next to each customer name I see the number of successful transactions they have conducted with my merchant
  
      it "returns the top 5 customers (by number of successful transactions with merchant)" do
        load_test_data_us_3

        expect(@merchant.top_five_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
      end

      it "counts the number of successful merchant transactions for each customer" do
        load_test_data_us_3

        expect(@merchant.top_five_customers[0].number_of_transactions).to eq 5
        expect(@merchant.top_five_customers[1].number_of_transactions).to eq 4
        expect(@merchant.top_five_customers[2].number_of_transactions).to eq 3
        expect(@merchant.top_five_customers[3].number_of_transactions).to eq 2
        expect(@merchant.top_five_customers[4].number_of_transactions).to eq 1
      end
    end 
  end
end
