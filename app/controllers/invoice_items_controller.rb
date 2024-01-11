class InvoiceItemsController < ApplicationController
  def create
    @invoice_item = InvoiceItem.create!(invoice_item_params)
  end

  def update
    invoice_item = InvoiceItem.find(params[:id])
    invoice = Invoice.find(invoice_item.invoice_id)
    merchant = Merchant.find(invoice_item.item.merchant_id)

    invoice_item.update(invoice_item_params)
      redirect_to "/merchants/#{merchant.id}/invoices/#{invoice.id}"
  end

  private

  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :status, :created_at, :updated_at)
  end
end