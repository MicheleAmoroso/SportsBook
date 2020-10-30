require 'rails_helper'

RSpec.describe Book, type: :model do
  before(:all) do
    @user = FactoryBot.create(:user)
    @ground = FactoryBot.create(:ground)
    @timetable = FactoryBot.create(:timetable)
  end

  after(:all) do
    @user.destroy
    @ground.destroy
    @timetable.destroy
  end

  describe "Creating a book" do
    it "should be permitted" do
      book = Book.new(user_id: @user.id, ground_id: @ground.id, timetable_id: @timetable.id).save
      expect(book).to eq(true)
    end

    it "is valid without the user" do
      book = Book.new(ground_id: @ground.id, timetable_id: @timetable.id).save
      expect(book).to eq(true)
    end

    it "is not valid without the ground" do
      book = Book.new(user_id: @user.id, timetable_id: @timetable.id).save
      expect(book).to eq(false)
    end

    it "is not valid without the timetable" do
      book = Book.new(ground_id: @ground.id, user_id: @user.id).save
      expect(book).to eq(false)
    end
    
  end
end
