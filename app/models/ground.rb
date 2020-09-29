class Ground < ApplicationRecord
  has_many :books
  has_many :reviews
  has_many :favorites
end
