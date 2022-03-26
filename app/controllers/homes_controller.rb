class HomesController < ApplicationController
  def top
    @all_ranks = Book.find(Favorite.group(:book_id).order('count(book_id) desc').limit(3).pluck(:book_id))
  end
end