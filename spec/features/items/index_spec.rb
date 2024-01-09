require "rails_helper"

RSpec.describe "the merchant items index page" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_2.id)
  end

  describe "User Story 6" do
    # As a merchant,
    # When I visit my merchant items index page (/merchants/:merchant_id/items)
    # I see a list of the names of all of my items
    # And I do not see items for any other merchant

    it "displays my items" do
      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)

      visit "/merchants/#{@merchant_2.id}/items"

      expect(page).to_not have_content(@item_1.name)
      expect(page).to_not have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
    end
  end

  describe "User Story 7" do
    # As a merchant,
    # When I click on the name of an item from the merchant items index page, (merchants/:merchant_id/items)
    # Then I am taken to that merchant's item's show page (/merchants/:merchant_id/items/:item_id)

    it "links to the merchant item show page" do
      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_link(@item_1.name)
      expect(page).to have_link(@item_2.name)

      click_link(@item_1.name)

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")

      # Return to merchant items index page
      visit "/merchants/#{@merchant_1.id}/items"
      click_link(@item_2.name)

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_2.id}")
    end
  end
end