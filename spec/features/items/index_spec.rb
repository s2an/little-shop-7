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

  describe "User Story 12" do
    # As a merchant
    # When I visit my items index page
    # Then I see the names of the top 5 most popular items ranked by total revenue generated
    # And I see that each item name links to my merchant item show page for that item
    # And I see the total revenue generated next to each item name
    #
    ### Notes on Revenue Calculation:
    #
    # - Only invoices with at least one successful transaction should count towards revenue
    # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
    # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

    it "shows the names of the five best selling items (by total item revenue)" do
      load_test_data_us_12

      visit merchant_items_path(merchant_id: @merchant.id)

      expect(page).to have_content("#{@item_6.name}")
      expect(page).to have_content("#{@item_5.name}")
      expect(page).to have_content("#{@item_4.name}")
      expect(page).to have_content("#{@item_3.name}")
      expect(page).to have_content("#{@item_2.name}")
      expect(page).to_not have_content("#{@item_7.name}") # Item from other merchant/invoice
    end

    it "shows the total revenue of the five best selling items" do
      load_test_data_us_12
      
      visit merchant_items_path(merchant_id: @merchant.id)

      # Note: could we use money gem?
      expect(page).to have_content("#{@merchant.most_popular_items[0].total_item_revenue/100}")
      expect(page).to have_content("#{@merchant.most_popular_items[1].total_item_revenue/100}")
      expect(page).to have_content("#{@merchant.most_popular_items[2].total_item_revenue/100}")
      expect(page).to have_content("#{@merchant.most_popular_items[3].total_item_revenue/100}")
      expect(page).to have_content("#{@merchant.most_popular_items[4].total_item_revenue/100}")
    end

    it "links to each item's invoice show page" do
      load_test_data_us_12

      visit merchant_items_path(merchant_id: @merchant.id)

      expect(page).to have_link "#{@item_6.name}", href: merchant_item_path(merchant_id: @merchant.id, item_id: @item_6.id)
      expect(page).to have_link "#{@item_5.name}", href: merchant_item_path(merchant_id: @merchant.id, item_id: @item_5.id)
      expect(page).to have_link "#{@item_4.name}", href: merchant_item_path(merchant_id: @merchant.id, item_id: @item_4.id)
      expect(page).to have_link "#{@item_3.name}", href: merchant_item_path(merchant_id: @merchant.id, item_id: @item_3.id)
      expect(page).to have_link "#{@item_2.name}", href: merchant_item_path(merchant_id: @merchant.id, item_id: @item_2.id)
    end
  end
end