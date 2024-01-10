require "rails_helper"

RSpec.describe "the merchant dashboard index page" do
  describe "User Story 1" do
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see the name of my merchant

    it "shows the merchant's name" do
      merchant = create(:merchant)

      visit merchant_dashboard_index_path(merchant_id: merchant.id)

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

      visit merchant_dashboard_index_path(merchant_id: merchant.id)

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

      visit merchant_dashboard_index_path(merchant_id: @merchant.id)

      expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name}")
      expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name}")
      expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name}")
      expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name}")
      expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name}")
    end

    it "shows each customer's number of successful transactions with the merchant" do
      load_test_data_us_3

      visit merchant_dashboard_index_path(merchant_id: @merchant.id)

      expect(page).to have_content("5 Transactions")
      expect(page).to have_content("4 Transactions")
      expect(page).to have_content("3 Transactions")
      expect(page).to have_content("2 Transactions")
      expect(page).to have_content("1 Transactions")
    end
  end

  describe "User Story 4" do
    # As a merchant
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see a section for "Items Ready to Ship"
    # In that section I see a list of the names of all of my items that have been ordered and have not yet been shipped,
    # And next to each Item I see the id of the invoice that ordered my item
    # And each invoice id is a link to my merchant's invoice show page

    it "shows the names of all items ready to ship (i.e. statuses of 'pending' or 'packaged')" do
      load_test_data_us_4

      visit merchant_dashboard_index_path(merchant_id: @merchant.id)

      expect(page).to have_content("#{@invoice_item_1.item.name}")
      expect(page).to have_content("#{@invoice_item_2.item.name}")
      expect(page).to have_content("#{@invoice_item_3.item.name}")
      expect(page).to have_content("#{@invoice_item_4.item.name}")
      expect(page).to have_content("#{@invoice_item_5.item.name}")
      expect(page).to have_content("#{@invoice_item_6.item.name}")
      expect(page).to have_content("#{@invoice_item_7.item.name}")
      expect(page).to have_content("#{@invoice_item_8.item.name}")
      expect(page).to have_content("#{@invoice_item_9.item.name}")
      expect(page).to_not have_content("#{@invoice_item_10.item.name}")
      expect(page).to_not have_content("#{@invoice_item_11.item.name}")
    end

    it "shows the invoice IDs of all items ready to ship (i.e. statuses of 'pending' or 'packaged')" do
      load_test_data_us_4

      visit merchant_dashboard_index_path(merchant_id: @merchant.id)

      expect(page).to have_content("Invoice ##{@invoice_item_1.invoice.id}")
      expect(page).to have_content("Invoice ##{@invoice_item_2.invoice.id}")
      expect(page).to have_content("Invoice ##{@invoice_item_3.invoice.id}")
      expect(page).to have_content("Invoice ##{@invoice_item_4.invoice.id}")
      expect(page).to have_content("Invoice ##{@invoice_item_5.invoice.id}")
      expect(page).to have_content("Invoice ##{@invoice_item_6.invoice.id}")
      expect(page).to have_content("Invoice ##{@invoice_item_7.invoice.id}")
      expect(page).to have_content("Invoice ##{@invoice_item_8.invoice.id}")
      expect(page).to have_content("Invoice ##{@invoice_item_9.invoice.id}")
      expect(page).to_not have_content("Invoice ##{@invoice_item_10.invoice.id}")
      expect(page).to_not have_content("Invoice ##{@invoice_item_11.invoice.id}")
    end

    it "links to each item's invoice show page" do
      load_test_data_us_4

      visit merchant_dashboard_index_path(merchant_id: @merchant.id)

      expect(page).to have_link "Invoice ##{@invoice_item_1.invoice.id}", href: merchant_invoice_path(merchant_id: @merchant.id, id: @invoice_item_1.invoice.id)
      expect(page).to have_link "Invoice ##{@invoice_item_2.invoice.id}", href: merchant_invoice_path(merchant_id: @merchant.id, id: @invoice_item_2.invoice.id)
      expect(page).to have_link "Invoice ##{@invoice_item_3.invoice.id}", href: merchant_invoice_path(merchant_id: @merchant.id, id: @invoice_item_3.invoice.id)
      expect(page).to have_link "Invoice ##{@invoice_item_4.invoice.id}", href: merchant_invoice_path(merchant_id: @merchant.id, id: @invoice_item_4.invoice.id)
      expect(page).to have_link "Invoice ##{@invoice_item_5.invoice.id}", href: merchant_invoice_path(merchant_id: @merchant.id, id: @invoice_item_5.invoice.id)
      expect(page).to have_link "Invoice ##{@invoice_item_6.invoice.id}", href: merchant_invoice_path(merchant_id: @merchant.id, id: @invoice_item_6.invoice.id)
      expect(page).to have_link "Invoice ##{@invoice_item_7.invoice.id}", href: merchant_invoice_path(merchant_id: @merchant.id, id: @invoice_item_7.invoice.id)
      expect(page).to have_link "Invoice ##{@invoice_item_8.invoice.id}", href: merchant_invoice_path(merchant_id: @merchant.id, id: @invoice_item_8.invoice.id)
      expect(page).to have_link "Invoice ##{@invoice_item_9.invoice.id}", href: merchant_invoice_path(merchant_id: @merchant.id, id: @invoice_item_9.invoice.id)
      expect(page).to_not have_link "Invoice ##{@invoice_item_10.invoice.id}", href: merchant_invoice_path(merchant_id: @merchant.id, id: @invoice_item_10.invoice.id)
      expect(page).to_not have_link "Invoice ##{@invoice_item_11.invoice.id}", href: merchant_invoice_path(merchant_id: @merchant.id, id: @invoice_item_11.invoice.id)
    end
  end

  describe "User Story 5" do
    # As a merchant
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # In the section for "Items Ready to Ship",
    # Next to each Item name I see the date that the invoice was created
    # And I see the date formatted like "Monday, July 18, 2019"
    # And I see that the list is ordered from oldest to newest

    it "displays each invoice's date in the format: Monday, January 8th, 2024" do
      load_test_data_us_4

      visit merchant_dashboard_index_path(merchant_id: @merchant.id)

      expect(page).to have_content("#{@invoice_item_1.invoice.created_at.strftime("%A, %B #{@invoice_item_1.invoice.created_at.day.ordinalize}, %Y")}")
      expect(page).to have_content("#{@invoice_item_2.invoice.created_at.strftime("%A, %B #{@invoice_item_2.invoice.created_at.day.ordinalize}, %Y")}")
      expect(page).to have_content("#{@invoice_item_3.invoice.created_at.strftime("%A, %B #{@invoice_item_3.invoice.created_at.day.ordinalize}, %Y")}")
      expect(page).to have_content("#{@invoice_item_4.invoice.created_at.strftime("%A, %B #{@invoice_item_4.invoice.created_at.day.ordinalize}, %Y")}")
      expect(page).to have_content("#{@invoice_item_5.invoice.created_at.strftime("%A, %B #{@invoice_item_5.invoice.created_at.day.ordinalize}, %Y")}")
      expect(page).to have_content("#{@invoice_item_6.invoice.created_at.strftime("%A, %B #{@invoice_item_6.invoice.created_at.day.ordinalize}, %Y")}")
      expect(page).to have_content("#{@invoice_item_7.invoice.created_at.strftime("%A, %B #{@invoice_item_7.invoice.created_at.day.ordinalize}, %Y")}")
      expect(page).to have_content("#{@invoice_item_8.invoice.created_at.strftime("%A, %B #{@invoice_item_8.invoice.created_at.day.ordinalize}, %Y")}")
      expect(page).to have_content("#{@invoice_item_9.invoice.created_at.strftime("%A, %B #{@invoice_item_9.invoice.created_at.day.ordinalize}, %Y")}")
    end
  end
end
