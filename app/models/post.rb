class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates_presence_of :title, :body, :user_id, :community_id
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
    message: "must be a valid image format" },
    size:         { less_than: 5.megabytes,
    message: "should be less than 5MB" }
  has_many :comments

  def score
    # difference between upvotes and downvotes
    if self.upvotes > 0 || self.downvotes > 0
      self.upvotes > 0 ? (self.upvotes - self.downvotes ) : (self.downvotes * -1 )
    else
      0
    end
  end

  def self.search(keyword)
    Post.where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  end

  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end

end