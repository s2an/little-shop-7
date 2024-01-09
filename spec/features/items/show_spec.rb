require "rails_helper"

RSpec.describe "the merchant items index page" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_2.id)
  end

  describe "User Story 7" do
    # As a merchant,
    # When I click on the name of an item from the merchant items index page, (merchants/:merchant_id/items)
    # Then I am taken to that merchant's item's show page (/merchants/:merchant_id/items/:item_id)
    # And I see all of the item's attributes including:
    
    # Name
    # Description
    # Current Selling Price

    it "displays item attributes" do
      visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content("Description: #{@item_1.description}")
      expect(page).to have_content("Current Price: #{@item_1.format_unit_price}")
    end
  end
end