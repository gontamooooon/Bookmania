class Room < ApplicationRecord
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy # 1つのルームにいるユーザ数は2人のためhas_manyになる
end
