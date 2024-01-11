class Admin::MerchantsController < ApplicationController 
  def index 
    @merchants= Merchant.all
  end

  def show 
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])

    if merchant.update(admin_merchants_params)
      flash[:success] = "Information has succesfully been updated"

      if params[:merchant] && params[:merchant][:status]
        redirect_to admin_merchants_path
      else
        redirect_to admin_merchant_path(merchant)
      end
      
    else 
      redirect_to edit_admin_merchant_path(merchant)
      flash[:failure] = merchant.errors.full_messages.join(' , ')
    end
  end

  private

  def admin_merchants_params
    params.require(:merchant).permit(:name, :status)
  end
  
end

# item = Item.find(params[:item_id])
# merchant = Merchant.find(params[:merchant_id])
# if item.update(item_params)
#   item.update(status: params[:status]) if params[:status].present?
#   redirect_to "/merchants/#{item.merchant_id}/items"
#   flash[:alert] = "Update Successful"
#   if params[:status].present?
#     item.update(status: params[:status])
#     redirect_to "/merchants/#{item.merchant_id}/items"
#     flash[:alert] = "Update Successful"
#   else
#     redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
#   end
# else
#   redirect_to "/merchants/#{merchant.id}/items/#{item.id}/edit"
#   flash[:alert] = "Error: Update Unsuccessful"