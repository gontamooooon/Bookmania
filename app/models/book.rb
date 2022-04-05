class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :book_image
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title, :author, :genre, :rate, presence: true
  validates :body, presence: true, length: { maximum: 500 }

  def get_book_image
    book_image.attached? ? book_image : 'no_image.jpg'
  end

  # いいね機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partical_match"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end

  # ソート機能
  # scope :recent, -> { order(created_at: :desc) }
end
