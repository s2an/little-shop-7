class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def format_unit_price
    '$%.2f' % "#{unit_price/100}"
  end
  
end
