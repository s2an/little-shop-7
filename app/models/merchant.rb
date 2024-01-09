class Merchant < ApplicationRecord
  validates :name, presence: true
  has_many :items

  def item_ids
    Item.where(merchant_id: id).pluck(:id)
  end

  def top_five_customers
    Customer.joins(invoices: [{ items: :merchant }, :transactions] ).select("customers.*, count(customers.id) as number_of_transactions").where("transactions.result = 1 AND merchant_id = #{self.id}").order("COUNT(customers.id) DESC").group(:id).limit(5)
  end
end
