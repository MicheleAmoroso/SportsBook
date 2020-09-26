class Ground < ApplicationRecord
  has_many :books
  has_many :reviews
end
