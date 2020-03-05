class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  enum pay_type: {
      'Cheque' => 1,
      'Credit card' => 2,
      'Purchase order' => 3
  }

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: Order.pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

end
