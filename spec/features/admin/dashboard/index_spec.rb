require 'rails_helper'

RSpec.describe "Admin Dashboard Index" do
  before(:each) do
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    customer_3 = create(:customer)
    customer_4 = create(:customer)
    customer_5 = create(:customer)
    @customer_6 = create(:customer, first_name: "Not a Name", last_name: "Not a Last Name")

    @top_5_customers = [customer_1, customer_2, customer_3, customer_4, customer_5]

    @top_5_customers.each do |customer|
      invoice = create(:invoice, customer: customer)
      create_list(:transaction, 10, invoice: invoice, result: 1)
    end

    invoice = create(:invoice, customer: @customer_6)
    create_list(:transaction, 10, invoice: invoice, result: 0)
    create_list(:transaction, 5, invoice: invoice, result: 1)

  end

  it "has a header indicating you are on the admin dashboard" do
    # 19. Admin Dashboard
    # As an admin,
    # When I visit the admin dashboard (/admin)
    visit admin_root_path

    # Then I see a header indicating that I am on the admin dashboard
    expect(page).to have_content("Admin Dashboard Official")
    # save_and_open_page
  end

  it "has links to the Admin Merchants Index and Admind Invouces Index" do
    # 20. Admin Dashboard Links

    # As an admin,
    # When I visit the admin dashboard (/admin)
    visit admin_root_path

    # Then I see a link to the admin merchants index (/admin/merchants)
    expect(page).to have_link("Admin Merchants Index")
    # And I see a link to the admin invoices index (/admin/invoices)
    expect(page).to have_link("Admin Invoices Index")
  end

  it "displays top 5 customers with the largest number of successful transactions" do
    # 21. Admin Dashboard Statistics - Top Customers

    # As an admin,
    # When I visit the admin dashboard (/admin)
    visit admin_root_path
  
    # Then I see the names of the top 5 customers
    expect(page).to have_content("Top 5 Customers")
    # who have conducted the largest number of successful transactions
    @top_5_customers.each do |customer|
      expect(page).to have_content(customer.first_name)
      expect(page).to have_content(customer.last_name)
      expect(page).to have_content(10)
    end
  
  #   expect(page).to_not have_content(.first_name)
  #   expect(page).to_not have_content(.last_name)
  end

  it "shows invoices that have not shipped" do
    #     22. Admin Dashboard Incomplete Invoices
    pending = create_list(:invoice_item, 5, status: 0)
    packaged = create_list(:invoice_item, 5, status: 1)
    shipped = create_list(:invoice_item, 5, status: 2)
 
    expected_ids = []
    pending.each do |invoice_item|
      expected_ids << invoice_item.invoice_id
    end

    packaged.each do |invoice_item|
      expected_ids << invoice_item.invoice_id
    end

    # As an admin,
    # When I visit the admin dashboard (/admin)
    visit admin_root_path
    # Then I see a section for "Incomplete Invoices"
    expect(page).to have_content("Incomplete Invoices")
    within(".incomplete_invoices") do
      # In that section I see a list of the ids of all invoices
      # That have items that have not yet been shipped
      # And each invoice id links to that invoice's admin show page
      expected_ids.each do |id|
        expect(page).to have_link("Invoice ##{id}", href: admin_invoice_path(id))
      end

      shipped.each do |invoice_item|
        expect(page).to_not have_content("Invoice ##{invoice_item.invoice_id}")
      end
    end
    
      # This was in main. I commented it out, but left it in while resolving merge conflict 32-us-22-admin-dashboard
    # expect(page).to_not have_content(@customer_6.first_name)
    # expect(page).to_not have_content(@customer_6.last_name)
    # And next to each customer name I see the number of successful transactions they have conducted
  end
end