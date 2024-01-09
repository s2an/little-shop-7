require 'rails_helper'

RSpec.describe "Admin Dashboard Index" do
  before (:each) do
    @merchant = create(:merchant) 
    @customer = create(:customer)
    @item = create(:item)
    # invoice = create!(:invoice, customer_id: customer.id)
    @invoice = create(:invoice)
    @transaction = create(:transaction)
    # @invoice_item = create() #look into this later
    # @item.invoice << [@shoe, @towel]
  end

  xit "has a header indicating you are on the admin dashboard" do
    # 19. Admin Dashboard

    # As an admin,
    # When I visit the admin dashboard (/admin)
    visit admin_root_path

    # Then I see a header indicating that I am on the admin dashboard
    expect(page).to have_content("Admin Dashboard Official")
  end

  xit "has links to the Admin Merchants Index and Admind Invouces Index" do
    # 20. Admin Dashboard Links

    # As an admin,
    # When I visit the admin dashboard (/admin)
    visit admin_root_path

    # Then I see a link to the admin merchants index (/admin/merchants)
    expect(page).to have_link("Admin Merchants Index")
    # And I see a link to the admin invoices index (/admin/invoices)
    expect(page).to have_link("Admin Invoices Index")
  end

  # it "displays top 5 customers with the largest number of successful transactions" do
  #   # 21. Admin Dashboard Statistics - Top Customers

  #   # As an admin,
  #   # When I visit the admin dashboard (/admin)
  #   visit root_path

  #   # Then I see the names of the top 5 customers
  #   expect(page).to have_content("Top 5 Customers")
  #   # who have conducted the largest number of successful transactions
  #   expect(page).to have_content()
  #   # And next to each customer name I see the number of successful transactions they have conducted
  #   expect(page).to have_content(.first_name)
  #   expect(page).to have_content(.last_name)

  #   expect(page).to have_content(.first_name)
  #   expect(page).to have_content(.last_name)

  #   expect(page).to have_content(.first_name)
  #   expect(page).to have_content(.last_name)

  #   expect(page).to have_content(.first_name)
  #   expect(page).to have_content(.last_name)

  #   expect(page).to_not have_content(.first_name)
  #   expect(page).to_not have_content(.last_name)
  # end
end