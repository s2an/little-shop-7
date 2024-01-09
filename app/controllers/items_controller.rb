class ItemsController < ApplicationController
  def create
    @item = Item.create!(item_params)
  end

  # def show
  #   @item = Item.find(params[:id])
  # end

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end