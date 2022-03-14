class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50}

  def receive_comment_count
    count = 0
    self.books.each do |book|
      count += book.book_comments.count
    end
    return count
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  #検索方法分岐
  def self.looks(search, word)
     if search == "perfect_match"
       @user = User.where("name LIKE?", "#{word}" )
     elsif search == "forward_match"
       @user = USer.where("name LIKE?", "#{word}%")
      elsif search == "backword_match"
        @user = User.where("name LIKE?", "%#{word}")
      elsif search == "partical_match"
        @user == User.where("name LIKE?", "%#{word}%")
      else
        @user = User.all
      end
  end
end
