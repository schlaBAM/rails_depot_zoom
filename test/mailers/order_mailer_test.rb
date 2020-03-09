# frozen_string_literal: true
require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Big Books Order Confirmation", mail.subject
    assert_equal ["doubledukes@outlook.com"], mail.to
    assert_equal ["schlabam@outlook.com"], mail.from
    assert_match(/1 x Programming Ruby 1.9/, mail.body.encoded)
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "Big Books Order Shipped!", mail.subject
    assert_equal ["doubledukes@outlook.com"], mail.to
    assert_equal ["schlabam@outlook.com"], mail.from
    assert_match(/1 x Programming Ruby 1.9/, mail.body.encoded)
  end
end
