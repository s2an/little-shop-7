require 'rails_helper'

RSpec.describe "admin merchant index" do
  # moved because I couldn't figure out how to target one instance of a button for US#27
  # before(:each) do 
  # end
  
  describe "User Story 24" do
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    # Then I see the name of each merchant in the system
    
    it "can see the name of each merchant in the system" do
      merchant_1 = create(:merchant)
      @merchants = create_list(:merchant, 10)
      
      visit(admin_merchants_path)
      
      @merchants.each do |merchant|
        expect(page).to have_content(merchant.name)
      end
    end
  end
  
  describe "User Story 27" do
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    # Then next to each merchant name I see a button to disable or enable that merchant.
    # When I click this button
    # Then I am redirected back to the admin merchants index
    # And I see that the merchant's status has changed
    
    it "adds an enable/disable button" do
      merchant = create(:merchant)
      # @merchants = create_list(:merchant, 10)

      visit admin_merchants_path

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content(merchant.name)
      expect(page).to have_content(merchant.status)
      expect(merchant.status).to_not have_content("Enabled")
      expect(page).to have_button("Enable")
      
      click_button("Enable")
      merchant.reload
      expect(page).to have_content("Enabled")
      
      click_button("Disable")
      merchant.reload
      
      expect(current_path).to eq(admin_merchants_path)
      expect(merchant.status).to eq("")
      expect(merchant.status).to_not have_content("Enabled")
    end
  end

  describe "User Story 28" do
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    # Then I see two sections, one for "Enabled Merchants" and one for "Disabled Merchants"
    # And I see that each Merchant is listed in the appropriate section

    it "groups the merchants by status" do
      merchant = create(:merchant)

      visit admin_merchants_path

      expect(page).to have_content("Disabled Merchants")
  
      within(".disabled-merchants") do
        expect(page).to have_content(merchant.name)
      end
      expect(merchant.status).to eq("")
      
      click_button("Enable")
      merchant.reload

      expect(merchant.status).to eq("Enabled")

      expect(page).to have_content("Enabled Merchants")
      
      within(".enabled-merchants") do
        expect(page).to have_content(merchant.name)
      end
    end
  end
end