class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum :status, { "in progress": 0, completed: 1, cancelled: 2 }

  def format_created_date
    created_at.to_date.to_formatted_s(:weekday_month_day_year)
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity") # do we need to convert this from cents to dollars?
  end

  def self.incomplete_invoices
    Invoice.joins(:invoice_items)
      .where(invoice_items: {status: [0,1]})
      .order(:created_at)
    # start with Invoice
    # join invoice_items table
    # filter for not-shipped invoice_items
    # 
  end
  
  def total_revenue_by_merchant(merchant)
    total_revenue_in_cents = InvoiceItem.joins(:item)
                                        .where(items: { merchant_id: merchant.id }, invoice_id: id)
                                        .sum("invoice_items.unit_price * invoice_items.quantity")

    total_revenue_in_dollars = format('%.2f', total_revenue_in_cents / 100.0)
  end

  def formatted_created_at
    created_at.strftime('%A, %B %d, %Y')
  end
end