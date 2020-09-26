class Review < ActiveRecord::Base
  belongs_to :ground
  belongs_to :user
end
