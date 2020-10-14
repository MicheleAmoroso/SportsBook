class Review < ActiveRecord::Base
  resourcify

  validates :rating, presence: true  
  validates :comments, presence: true
  validates :user_id, presence: true
  validates :ground_id, presence: true
  
  belongs_to :ground
  belongs_to :user
end
