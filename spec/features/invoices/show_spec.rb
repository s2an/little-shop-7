require "rails_helper"

RSpec.describe "the merchant invoices show page" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_2.id)

    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_1.id)
  end

  describe "User Story 15" do
    # As a merchant
    # When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # Then I see information related to that invoice including:

    # Invoice id
    # Invoice status
    # Invoice created_at date in the format "Monday, July 18, 2019"
    # Customer first and last name
    
    it "displays information about a given invoice" do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      expect(page).to have_content("Status: #{@invoice_1.status.titleize}")
      expect(page).to have_content("Created on: #{@invoice_1.format_created_date}")
      expect(page).to have_content("Customer: #{@invoice_1.customer.full_name}")
    end
  end

  describe "User Story 16" do
    # As a merchant
    # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # Then I see all of my items on the invoice including:

    # Item name
    # The quantity of the item ordered
    # The price the Item sold for
    # The Invoice Item status
    # And I do not see any information related to Items for other merchants

    it "displays a table of items" do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content("Items on this Invoice:")
      within('table') do
        expect(page).to have_content('Item Name')
        expect(page).to have_content('Quantity')
        expect(page).to have_content('Unit Price')
        expect(page).to have_content('Status')

        InvoiceItem.where(item_id: @merchant_1.item_ids).each do |invoice_item|
          expect(page).to have_content(invoice_item.item.name)
          expect(page).to have_content(invoice_item.quantity)
          expect(page).to have_content(invoice_item.format_unit_price)
          expect(page).to have_content(invoice_item.status)
        end
      end
    end

    it "displays the correct items in the table based on the merchant who is viewing" do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@invoice_item_1.item.name) # should see item 1 because it belongs to merchant 1
      expect(page).to_not have_content(@invoice_item_2.item.name) # should NOT see item 2 because it does NOT belong to merchant 1

      # Visit the same invoice page, but view as a different merchant
      visit "/merchants/#{@merchant_2.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@invoice_item_2.item.name) # should see item 2 because it belongs to merchant 2
      expect(page).to_not have_content(@invoice_item_1.item.name) # should NOT see item 1 because is does NOT belong to merchant 2
    end
  end
  
  describe "User Story 17" do
    # As a merchant
    # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # Then I see the total revenue that will be generated from all of my items on the invoice

    it "displays total revenue generated from my items on the invoice" do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content("Total Revenue: $#{@invoice_1.total_revenue_by_merchant(@merchant_1)}")

      # Visit the same invoice page, but view as a different merchant
      visit "/merchants/#{@merchant_2.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_content("Total Revenue: $#{@invoice_1.total_revenue_by_merchant(@merchant_2)}")
    end
  end

  describe "User Story 18" do
    # As a merchant
    # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # I see that each invoice item status is a select field
    # And I see that the invoice item's current status is selected
    # When I click this select field,
    # Then I can select a new status for the Item,
    # And next to the select field I see a button to "Update Item Status"
    # When I click this button
    # I am taken back to the merchant invoice show page
    # And I see that my Item's status has now been updated

    it "updates status when Submit Item Status is clicked" do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      expect(page).to have_select('status', with_options: ["pending", "packaged", "shipped"])
      expect(page).to have_content(@invoice_item_1.status)
      expect(page).to have_button("Update Item Status")

      within("tr:contains('#{@invoice_item_1.item.name}')") do
        select "packaged", from: "status"
        click_button "Update Item Status"
      end

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")

      within("tr:contains('#{@invoice_item_1.item.name}')") do
        expect(page).to have_content("packaged")
      end
    end
  end
end