class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :book_image
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title, presence: true
  validates :author, presence: true
  validates :body, presence: true, length: {maximum:500}
  validates :genre, presence: true

  def get_book_image
    (book_image.attached?) ? book_image : 'no_image.jpg'
  end
end
