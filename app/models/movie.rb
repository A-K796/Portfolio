class Movie < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  attachment :image
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'likes'
      return find(Like.group(:movie_id).order('count(movie_id) desc').pluck(:movie_id))
    when 'dislikes'
      return find(Favorite.group(:post_id).order('count(post_id) asc').pluck(:post_id))
    end
  end

  def favorited_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
