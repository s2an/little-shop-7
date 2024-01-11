require 'rails_helper'

RSpec.describe "admin/merchants/edit_spec.rb" do
  
  describe "User Story 26" do
    # As an admin,
    # When I visit a merchant's admin show page (/admin/merchants/:merchant_id)
    # Then I see a link to update the merchant's information.
    # When I click the link
    # Then I am taken to a page to edit this merchant
    # And I see a form filled in with the existing merchant attribute information
    # When I update the information in the form and I click ‘submit’
    # Then I am redirected back to the merchant's admin show page where I see the updated information
    # And I see a flash message stating that the information has been successfully updated.
    
    it " can update the admin merchant" do 
      merchant = create(:merchant)
      
      visit admin_merchant_path(merchant)
      
      expect(page).to have_link("Update Merchant Information")
      click_on("Update Merchant Information")
      
      expect(current_path).to eq(edit_admin_merchant_path(merchant))
      expect(page).to have_content(merchant.name)
      
      fill_in "Name", with: "Gonzo Gazeebo"
      click_on('Submit')
      # save_and_open_page <-doesn't work, but the test passes??
      expect(current_path).to eq(admin_merchant_path(merchant))
      expect(page).to have_content("Gonzo Gazeebo")
      expect(page).to_not have_content(merchant.name)
      expect(page).to have_content("Information has succesfully been updated")
    end
    
    it "US26-soft failure test: throws an error if update doesn't work :)" do
      #As an admin
      # when I visit admin merchants edit page
      merchant = create(:merchant)
      
      visit admin_merchant_path(merchant)
      click_on("Update Merchant Information")
      # And I input invalid data (blank field)
      fill_in("Name", with: "")
      # and click submit
      click_button("Submit")
      # I am taken back to the admin merchants edit page
      expect(current_path).to eq(edit_admin_merchant_path(merchant))
      # And I see a flash message that tells me name can't be blank
      expect(page).to have_content("Name can't be blank")
      # And the merchant data was not changed
      expect(page).to have_content(merchant.name)
    end
  end
end
