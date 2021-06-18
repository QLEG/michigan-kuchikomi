class Good < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :goods_condition, presence: true
  validates :delivery_condition, presence: true
  validates :area, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :size, presence: true
  validates :name, presence: true

  validates :description, presence: true, length: { maximum: 500 }
  has_one_attached :image
end
