class Review < ActiveRecord::Base
  resourcify
  
  belongs_to :ground
  belongs_to :user
end
