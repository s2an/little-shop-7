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

  describe "User Story 9" do
    # As a merchant
    # When I visit my items index page (/merchants/:merchant_id/items)
    # Next to each item name I see a button to disable or enable that item.
    # When I click this button
    # Then I am redirected back to the items index
    # And I see that the items status has changed

    it "displays enable and disable buttons to update the item status" do
      visit "/merchants/#{@merchant_1.id}/items"
  
      within("tr:contains('#{@item_1.name}')") do
        expect(page).to have_button("Enable")

        click_button("Enable")

        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")

        expect(page).to have_button("Disable")

        click_button("Disable")

        expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")

        expect(page).to have_button("Enable")
      end
    end
  end

  describe "User Story 10" do
    # As a merchant,
    # When I visit my merchant items index page
    # Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
    # And I see that each Item is listed in the appropriate section

    it "displays enabled/disabled items in sections" do
      visit "/merchants/#{@merchant_1.id}/items"

      within("tbody:contains('Disabled Items')") do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
      end
      
      within("tr:contains('#{@item_1.name}')") do
      click_button("Enable")
      end
    
      within("tbody:contains('Enabled Items')") do
        expect(page).to have_content(@item_1.name)
      end
    end
  end

  describe "User Story 11" do
    # As a merchant
    # When I visit my items index page
    # I see a link to create a new item.
    # When I click on the link,
    # I am taken to a form that allows me to add item information.
    # When I fill out the form I click ‘Submit’
    # Then I am taken back to the items index page
    # And I see the item I just created displayed in the list of items.
    # And I see my item was created with a default status of disabled.

    it "has a link to create new items" do
      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_link("New Item")

      click_link("New Item")

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")
      fill_in "Name", with: "Black Shoelaces"
      fill_in "Description", with: "long black shoelaces"
      fill_in "unit_price", with: "1000"
      click_on('Submit')

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
      
      within("tbody:contains('Disabled Items')") do
        expect(page).to have_content("Black Shoelaces")
      end
    end
  end
end