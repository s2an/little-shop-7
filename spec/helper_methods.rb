# Test data for User Story 3
def load_test_data_us_3
    @merchant = create(:merchant)

    @item = create(:item, merchant_id: @merchant.id)

    # Creating customers
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoices = create_list(:invoice, 15) do |invoice, i|
        if i < 5 # adding 5 invoices to customer_1
        invoice.customer_id = @customer_1.id
        invoice.save!
        elsif 5 <= i && i < 9 # adding 4 invoices to customer_2
        invoice.customer_id = @customer_2.id
        invoice.save!
        elsif 9 <= i && i < 12 # # adding 3 invoices to customer_3
        invoice.customer_id = @customer_3.id
        invoice.save!
        elsif 12 <= i && i < 14 # adding 2 invoices to customer_4
        invoice.customer_id = @customer_4.id
        invoice.save!
        else # adding 1 invoice to customer_5
        invoice.customer_id = @customer_5.id
        invoice.save!
        end
    end

    # Creating invoice_items and transactions, with transactions set to "successful"
    @invoices.each do |invoice|
        create(:invoice_item, invoice_id: invoice.id, item_id: @item.id)
        create(:transaction, invoice_id: invoice.id, result: 1)
    end
end