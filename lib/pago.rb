# frozen_string_literal: true
require 'ostruct'
class Pago
  def self.make_payment(order_id:, payment_method:, payment_details:)
    Rails.logger.info("Attempting to process order #{order_id}...")
    case payment_method
    when :cheque
      Rails.logger.info("Processing cheque: " +
                            payment_details.fetch(:routing).to_s + '/' +
                            payment_details.fetch(:account).to_s)
    when :credit_card
      Rails.logger.info("Processing credit card: " +
                            payment_details.fetch(:cc_num).to_s + '/' +
                            payment_details.fetch(:expiration_month).to_s + '/' +
                            payment_details.fetch(:expiration_year).to_s)
    when :po
      Rails.logger.info("Processing purchase order: " +
                            payment_details.fetch(:po_num).to_s)
    else
      raise "Unknown payment method - #{payment_method}."
    end
    sleep(3) unless Rails.env.test?
    Rails.logger.info("Processing Payment Completed")
    OpenStruct.new(succeeded?: true)
  end
end
