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
  # FBに記載ありの方　looks→search_by_name（わかりやすく命名）
  def self.search_by_name(search, word)
    if search == "perfect_match"
      where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      where("name LIKE?", "%#{word}")
    elsif search == "partical_match"
      where("name LIKE?", "%#{word}%")
    else
      all
    end
  end
  
  # FB記載なし=自分で実装した方
  # def self.looks(search, word)
  #   if search == "perfect_match"
  #     @book = Book.where("title LIKE?", "#{word}")
  #   elsif search == "forward_match"
  #     @book = Book.where("title LIKE?", "#{word}%")
  #   elsif search == "backward_match"
  #     @book = Book.where("title LIKE?", "%#{word}")
  #   elsif search == "partical_match"
  #     @book = Book.where("title LIKE?", "%#{word}%")
  #   else
  #     @book = Book.all
  #   end
  # end
  
  #ソート機能
  def self.order_by(condition)
    if condition == "new_arrival_order"
      order(created_at: :desc)
    elsif condition == "posting_order"
      order(created_at: :asc)
    elsif condition == "highly_rated"
      order(rate: :desc)
    elsif condition == "low_rating"
      order(rate: :asc)
    else
      order(created_at: :desc)
    end
  end


  #ソート機能
  # scope :recent, -> { order(created_at: :desc) }
end
