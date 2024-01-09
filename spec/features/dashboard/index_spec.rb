require "rails_helper"

RSpec.describe "the merchant dashboard index page" do
  describe "User Story 1" do
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see the name of my merchant

    it "shows the merchant's name" do
      merchant = create(:merchant)

      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_content(merchant.name)
    end
  end

  describe "User Story 2" do
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see link to my merchant items index (/merchants/:merchant_id/items)
    # And I see a link to my merchant invoices index (/merchants/:merchant_id/invoices)
    
    it "shows links to the merchant's item and invoice indices" do
      merchant = create(:merchant)

      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_link 'View Items', href: "/merchants/#{merchant.id}/items"
      expect(page).to have_link 'View Invoices', href: "/merchants/#{merchant.id}/invoices"
    end
  end

  describe "User Story 3" do
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions with my merchant
    # And next to each customer name I see the number of successful transactions they have conducted with my merchant

    it "shows the names of the top 5 customers (by number of successful transactions with merchant)" do
      load_test_data_us_3

      visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
      expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name}")
      expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name}")
      expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name}")
      expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name}")
    end

    it "shows each customer's number of successful transactions with the merchant" do
      load_test_data_us_3

      visit "/merchants/#{@merchant.id}/dashboard"

      save_and_open_page

      expect(page).to have_content("5 Transactions")
      expect(page).to have_content("4 Transactions")
      expect(page).to have_content("3 Transactions")
      expect(page).to have_content("2 Transactions")
      expect(page).to have_content("1 Transactions")
    end
  end
end
