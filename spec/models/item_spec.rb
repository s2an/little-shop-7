require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "assocations" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many :invoices }
  end

  describe "methods" do
    it "formats unit price" do
      @item_1 = create(:item, unit_price: 1000)
      @item_2 = create(:item, unit_price: 900)

      expect(@item_1.format_unit_price).to eq("$10.00")
      expect(@item_2.format_unit_price).to eq("$9.00")
    end
  end
end
