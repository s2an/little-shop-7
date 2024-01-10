require 'rails_helper'

RSpec.describe "admin merchant index" do
  # moved because I couldn't figure out how to target one instance of a button
  # before(:each) do 
  # end
  
  describe "User Story 24" do
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    # Then I see the name of each merchant in the system
    
    it "can see the name of each merchant in the system" do
      @merchant = create(:merchant)
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

      visit admin_merchants_path

      expect(page).to have_content(merchant.name)
      expect(merchant.status).to_not have_content("Enabled")
      expect(page).to have_button("Enable")
      expect(page).to have_button("Disable")
      
      click_button("Enable")
      
      expect(page).to have_content("Enabled")
      
      click_button("Disable")
      
      expect(merchant.status).to_not have_content("Enabled")
    end
  end

end