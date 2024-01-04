require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "assocations" do
    it { should belong_to :invoice }
  end

  describe "enums" do
    it { should define_enum_for(:result).with_values([:failed, :success]) }
  end

end
