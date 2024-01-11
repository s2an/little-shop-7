class Merchant < ApplicationRecord
  validates :name, presence: true
  has_many :items

  def item_ids
    Item.where(merchant_id: id).pluck(:id)
  end

  def top_five_customers
    Customer.joins(invoices: [{ items: :merchant }, :transactions] )
            .select("customers.*, count(customers.id) as number_of_transactions")
            .where("transactions.result = 1 AND merchant_id = #{self.id}")
            .order("COUNT(customers.id) DESC")
            .group(:id)
            .limit(5)
  end

  def items_ready_to_ship
    InvoiceItem.joins(:invoice, { item: :merchant })
               .where("invoice_items.status < 2 AND merchants.id = #{self.id}")
               .order("invoice_items.created_at")
  end

  def top_5_sellers 
    Merchant
  end
end
