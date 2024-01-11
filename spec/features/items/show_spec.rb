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

  describe "User Story 8" do
    # As a merchant,
    # When I visit the merchant show page of an item (/merchants/:merchant_id/items/:item_id)
    # I see a link to update the item information.
    # When I click the link
    # Then I am taken to a page to edit this item
    # And I see a form filled in with the existing item attribute information
    # When I update the information in the form and I click ‘submit’
    # Then I am redirected back to the item show page where I see the updated information
    # And I see a flash message stating that the information has been successfully updated.
    it "updates item" do
      visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"

      expect(page).to have_link("Update Item")

      click_link("Update Item")

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")
      expect(page).to have_field("name", with: @item_1.name)
      expect(page).to have_field("description", with: @item_1.description)
      expect(page).to have_field("unit_price", with: @item_1.unit_price)
      expect(page).to have_button("Submit")

      fill_in "name", with: "Black Shoelaces"
      fill_in "description", with: "long black shoelaces"
      click_button("Submit")

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
      expect(page).to have_content("Black Shoelaces")
      expect(page).to have_content("Description: long black shoelaces")
    end
  end
end