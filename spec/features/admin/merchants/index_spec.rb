require 'rails_helper'

RSpec.describe "admin merchant index" do
  before(:each) do 
    @merchant = create(:merchant)
    @merchants = create_list(:merchant, 10)
  end

  it " can see the name of each merchant in the system" do
    # 24. Admin Merchants Index

    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    visit(admin_merchants_path) 
    # Then I see the name of each merchant in the system
    @merchants.each do |merchant|
      expect(page).to have_content(merchant.name)
    end
  end

  xit "shows top 5 merchants by revenue" do
    # 30. Admin Merchants: Top 5 Merchants by Revenue

    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    visit admin_merchants_path
    # Then I see the names of the top 5 merchants by total revenue generated
    # And I see that each merchant name links to the admin merchant show page for that merchant
    # And I see the total revenue generated next to each merchant name


    top_5_merchants = Merchant.top_5_sellers
    expect(top_5_merchants.count).to eq(5)
    within(".top_5") do
      top_5_merchants.each do |merchant|
        expect(page).to have_link(merchant.name, href:admin_merchant(merchant))
        expect(page).to have_content("Merchant Name: #{merchant.name}, Total Revenue: #{merchant.total_revenue}")
      end
    end
    
  end
end