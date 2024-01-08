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
end
