class Item < ApplicationRecord
  attachment:image
  
  has_many :cart_items,dependent: :destroy
  has_many :order_items,dependent: :destroy
  belongs_to :genre
  
  validates :genre_id, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image, presence: true
  
  def add_tax_price
    (self.price ＊ 1.1).round
  end
end
