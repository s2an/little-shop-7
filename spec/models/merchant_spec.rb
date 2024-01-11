require 'rails_helper'
require 'helper_methods'

RSpec.describe Merchant, type: :model do
  describe "associations" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "helper methods" do
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

    describe "#items_ready_to_ship (User Story 4 and 5)" do
      ## USER STORY 4: MERCHANT DASHBOARD ITEMS READY TO SHIP
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

      ## USER STORY 5: MERCHANT DASHBOARD 
      # As a merchant
      # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
      # In the section for "Items Ready to Ship",
      # Next to each Item name I see the date that the invoice was created
      # And I see the date formatted like "Monday, July 18, 2019"
      # And I see that the list is ordered from oldest to newest

      it "sorts the list from oldest to newest" do
        load_test_data_us_4

        expect(@merchant.items_ready_to_ship).to eq([@invoice_item_1, @invoice_item_2, @invoice_item_3, @invoice_item_4, @invoice_item_5, @invoice_item_6, @invoice_item_7, @invoice_item_8, @invoice_item_9])
      end
    end
  end
    describe "class method" do 
      describe "top_5_sellers " do 
        xit "list out the top 5  sellers" do 
          @merchants = create_list(:merchant, 10)
          merchant_1 = create(:merchant)
          merchant_2 = create(:merchant)
          merchant_3 = create(:merchant)
          merchant_4 = create(:merchant)
          merchant_5 = create(:merchant)
          item_1 = create(:item, merchant: merchant_1)
          item_2 = create(:item, merchant: merchant_2)
          item_3 = create(:item, merchant: merchant_3)
          item_4 = create(:item, merchant: merchant_4)
          item_5 = create(:item, merchant: merchant_5)
          invoice_1 = create(:invoice)
          invoice_2 = create(:invoice)
          invoice_3 = create(:invoice)
          invoice_4 = create(:invoice)
          invoice_5 = create(:invoice)
          invoice_6 = create(:invoice)
          invoice_7 = create(:invoice)
          invoice_8 = create(:invoice)
          invoice_9 = create(:invoice)
          invoice_10 = create(:invoice)
          transaction_1=create(:transaction,result:1, invoice:invoice_1)
          transaction_2=create(:transaction,result:1, invoice:invoice_2)
          transaction_3=create(:transaction,result:1, invoice:invoice_3)
          transaction_4=create(:transaction,result:1, invoice:invoice_4)
          transaction_5=create(:transaction,result:1, invoice:invoice_5)
          

          InvoiceItem.create(item:item_1, invoice: invoice_1, unit_price:50, quantity:40)
          InvoiceItem.create(item:item_1, invoice: invoice_2,unit_price:45, quantity:35)
          InvoiceItem.create(item:item_1, invoice: invoice_3,unit_price:40, quantity:30)
          InvoiceItem.create(item:item_1, invoice: invoice_4,unit_price:35, quantity:25)
          InvoiceItem.create(item:item_2, invoice: invoice_5,unit_price:30, quantity:20)
          InvoiceItem.create(item:item_2, invoice: invoice_6,unit_price:25, quantity:15)
          InvoiceItem.create(item:item_2, invoice: invoice_7,unit_price:20, quantity:10)
          InvoiceItem.create(item:item_3, invoice: invoice_8,unit_price:15, quantity:5)
          InvoiceItem.create(item:item_4, invoice: invoice_9,unit_price:10, quantity:35)
          InvoiceItem.create(item:item_5, invoice: invoice_10,unit_price:5, quantity:30)
          expect(Merchant.top_5_seller).to eq([merchant_1, merchant_2, merchant_4, merchant_5, merchant_3])
          # Notes on Revenue Calculation:
    # - Only invoices with at least one successful transaction should count towards revenue
    # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
    # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
        end
      end
    end
end
