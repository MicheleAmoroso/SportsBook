class Ground < ApplicationRecord

  resourcify

  has_many :books
  has_many :reviews
  has_many :favorites

  has_one_attached :ground_image
end
