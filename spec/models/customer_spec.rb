require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "associations" do
    it { should have_many :invoices }
  end

  describe "methods" do
    it "can display customer first and last name" do
      @customer = Customer.create(first_name: "John", last_name: "Doe")

      expect(@customer.full_name).to eq("John Doe")
    end
  end
end
