class Book < ApplicationRecord

  resourcify
  
  belongs_to :ground
  belongs_to :timetable
end
