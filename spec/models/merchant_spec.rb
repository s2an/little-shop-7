require 'rails_helper'
require 'helper_methods'

RSpec.describe Merchant, type: :model do
  describe "associations" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
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

    describe "#items_ready_to_ship (User Story 4)" do
      # As a merchant
      # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
      # Then I see a section for "Items Ready to Ship"
      # In that section I see a list of the names of all of my items that have been ordered and have not yet been shipped,
      # And next to each Item I see the id of the invoice that ordered my item
      # And each invoice id is a link to my merchant's invoice show page
  
      it "returns all items that have been ordered but not yet shipped" do
        load_test_data_us_4

        expect(@merchant.items_ready_to_ship.sort).to eq([@invoice_item_1, @invoice_item_2, @invoice_item_3, @invoice_item_4, @invoice_item_5, @invoice_item_6, @invoice_item_7, @invoice_item_8, @invoice_item_9].sort)
      end
    end 
  end
end
