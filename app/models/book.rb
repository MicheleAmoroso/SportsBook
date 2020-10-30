class Book < ApplicationRecord

  resourcify

  validates :ground_id, presence: true
  validates :timetable_id, presence: true
  
  belongs_to :ground
  belongs_to :timetable
end
