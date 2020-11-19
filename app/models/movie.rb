class Movie < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  attachment :image
  has_many :likes, dependent: :destroy

  def favorited_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
