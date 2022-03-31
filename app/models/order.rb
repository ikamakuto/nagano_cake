class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :customer

  validates :post_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

  enum payment_method:{credit_card:0, transfer:1}
  enum ordering_status:{payment_waiting:0, confirmation:1, production:2, ready_to_ship:3, shipping_finih:4}

  def sum_of_order_price
    total_price+shipping_fee
  end
end
