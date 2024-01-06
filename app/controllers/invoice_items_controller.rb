class InvoiceItemsController < ApplicationController
  def create
    @invoice_item = InvoiceItem.create!(invoice_item_params)
  end

  private

  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :status, :created_at, :updated_at)
  end
end