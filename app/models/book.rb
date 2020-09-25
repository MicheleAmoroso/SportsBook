class Book < ApplicationRecord
  belongs_to :ground
  belongs_to :timetable
end
