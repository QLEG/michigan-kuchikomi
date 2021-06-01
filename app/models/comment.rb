class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates_presence_of :message, :user_id, :post_id
  
end