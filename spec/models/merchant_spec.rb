require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "associations" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "methods" do
    it "finds item ids for a given merchant" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_1.id)
      item_3 = create(:item, merchant_id: merchant_2.id)
      item_4 = create(:item, merchant_id: merchant_2.id)
      
      expect(merchant_1.item_ids).to eq([item_1.id, item_2.id])
      expect(merchant_2.item_ids).to eq([item_3.id, item_4.id])
    end
end
