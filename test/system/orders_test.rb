# frozen_string_literal: true
require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name

    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end

  test "check routing number" do
    visit store_index_url

    click_on 'Add to Cart', match: :first
    click_on 'Checkout'

    fill_in 'order_name', with: 'Cornelius Broheim'
    fill_in 'order_address', with: '420 Expensive Mansion Way Townville CA 90210'
    fill_in 'order_email', with: 'doubledukes@outlook.com'

    assert_no_selector "#order_routing_number"
    assert_no_selector "#order_account_number"

    select 'Cheque', from: 'pay_type'

    assert_selector "#order_routing_number"
    assert_selector "#order_account_number"
  end

  test "check credit card" do
    visit store_index_url

    click_on 'Add to Cart', match: :first
    click_on 'Checkout'

    fill_in 'order_name', with: 'Cornelius Broheim'
    fill_in 'order_address', with: '420 Expensive Mansion Way Townville CA 90210'
    fill_in 'order_email', with: 'doubledukes@outlook.com'

    assert_no_selector "#order_credit_card_number"
    assert_no_selector "#order_expiration_date"

    select 'Credit Card', from: 'pay_type'

    assert_selector "#order_credit_card_number"
    assert_selector "#order_expiration_date"
  end

  test "check purchase order" do
    visit store_index_url

    click_on 'Add to Cart', match: :first
    click_on 'Checkout'

    fill_in 'order_name', with: 'Cornelius Broheim'
    fill_in 'order_address', with: '420 Expensive Mansion Way Townville CA 90210'
    fill_in 'order_email', with: 'doubledukes@outlook.com'

    assert_no_selector "#order_po_number"

    select 'Purchase Order', from: 'pay_type'

    assert_selector "#order_po_number"
  end

  test 'full order workflow' do
    LineItem.delete_all
    Order.delete_all
    visit store_index_url

    click_on 'Add to Cart', match: :first
    click_on 'Checkout'

    fill_in 'Name', with: 'Cornelius Broheim'
    fill_in 'Address', with: '420 Expensive Mansion Way Townville CA 90210'
    fill_in 'Email', with: 'doubledukes@outlook.com'

    assert_no_selector "#order_routing_number"
    assert_no_selector "#order_account_number"

    select 'Cheque', from: 'pay_type'

    assert_selector "#order_routing_number"
    assert_selector "#order_account_number"

    fill_in 'Routing Number', with: '123456'
    fill_in 'Account Number', with: '098765'

    perform_enqueued_jobs do
      click_on 'Create Order'
    end

    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first
    assert_equal 'Cornelius Broheim', order.name
    assert_equal '420 Expensive Mansion Way Townville CA 90210', order.address
    assert_equal 'doubledukes@outlook.com', order.email
    assert_equal 'Cheque', order.pay_type
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal ['doubledukes@outlook.com'], mail.to
    assert_equal 'mr fun mail <schlabam@outlook.com>', mail[:from].value
    assert_equal 'Big Books Order Confirmation', mail.subject
  end
end
