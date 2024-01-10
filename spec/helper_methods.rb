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

def load_test_data_us_4
    @merchant = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, merchant_id: @merchant.id)
    @item_2 = create(:item, merchant_id: @merchant.id)
    @item_3 = create(:item, merchant_id: @merchant.id)
    @item_4 = create(:item, merchant_id: @merchant.id)
    @item_5 = create(:item, merchant_id: @merchant.id)
    @item_6 = create(:item, merchant_id: @merchant.id)
    @item_7 = create(:item, merchant_id: @merchant.id)
    @item_8 = create(:item, merchant_id: @merchant.id)
    @item_9 = create(:item, merchant_id: @merchant.id)
    @item_10 = create(:item, merchant_id: @merchant.id) # Sad path should exclude, invalid status from @invoice_item_10
    @item_11 = create(:item, merchant_id: @merchant_2.id) # Belongs to @merchant_2 for sad path testing

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, status: 0)
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, status: 0)
    @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, status: 0)
    @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, status: 0)
    @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, status: 0)
    @invoice_item_6 = create(:invoice_item, item_id: @item_6.id, status: 1)
    @invoice_item_7 = create(:invoice_item, item_id: @item_7.id, status: 1)
    @invoice_item_8 = create(:invoice_item, item_id: @item_8.id, status: 1)
    @invoice_item_9 = create(:invoice_item, item_id: @item_9.id, status: 1)
    @invoice_item_10 = create(:invoice_item, item_id: @item_10.id, status: 2) # Sad path should exclude, due to status: 2 (shipped)
    @invoice_item_11 = create(:invoice_item, item_id: @item_11.id) # Sad path should exclude, due to @item_11 belonging to @merchant_2 
end

def load_test_data_us_12
    def format_unit_price
        '$%.2f' % "#{total_item_revenue/100}"
    end

    @merchant = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, merchant_id: @merchant.id)
    @item_2 = create(:item, merchant_id: @merchant.id)
    @item_3 = create(:item, merchant_id: @merchant.id)
    @item_4 = create(:item, merchant_id: @merchant.id)
    @item_5 = create(:item, merchant_id: @merchant.id)
    @item_6 = create(:item, merchant_id: @merchant.id) # Sad path should exclude, sixth most popular item from @merchant_1
    @item_7 = create(:item, merchant_id: @merchant_2.id) # Sad path should exclude, belongs to @merchant_2

    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)

    @transaction = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction = create(:transaction, invoice_id: @invoice_2.id, result: 1)

    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 5) # Sad path should exclude, sixth most popular item from @merchant_1
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 10) # Sad path should exclude, sixth most popular item from @merchant_1
    @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 10, unit_price: 10)
    @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 10, unit_price: 15)
    @invoice_item_5 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 10, unit_price: 15)
    @invoice_item_6 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 10, unit_price: 20)
    @invoice_item_7 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_4.id, quantity: 10, unit_price: 20)
    @invoice_item_8 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_4.id, quantity: 10, unit_price: 25)
    @invoice_item_9 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_5.id, quantity: 10, unit_price: 25)
    @invoice_item_10 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_5.id, quantity: 10, unit_price: 30)
    @invoice_item_11 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_6.id, quantity: 10, unit_price: 30)
    @invoice_item_12 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_6.id, quantity: 10, unit_price: 35)
    @invoice_item_13 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_7.id, quantity: 10, unit_price: 35) # Sad path should exclude, belongs to @merchant_2
    @invoice_item_14 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_7.id, quantity: 10, unit_price: 40) # Sad path should exclude, belongs to @merchant_2
end