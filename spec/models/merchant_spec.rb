require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "assocations" do
    it { should have_many :items }
  end
end
