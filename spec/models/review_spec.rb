require 'rails_helper'

RSpec.describe Review, type: :model do

  before(:all) do
    @user = FactoryBot.create(:user)
    @ground = FactoryBot.create(:ground)
  end

  after(:all) do
    @user.destroy
    @ground.destroy
  end

  describe "Creating a review" do
    it "should be permitted" do
      review = Review.new(rating: 4, comments: "Bel campo", user_id: @user.id, ground_id: @ground.id).save
      expect(review).to eq(true)
    end

    it "is not valid without the rating" do
      review = Review.new(comments: "Bel campo", user_id: @user.id, ground_id: @ground.id).save
      expect(review).to eq(false)
    end

    it "is not valid without the comments" do
      review = Review.new(rating: 4, user_id: @user.id, ground_id: @ground.id).save
      expect(review).to eq(false)
    end

    it "is not valid without the user" do
      review = Review.new(rating: 4, comments: "Bel campo", ground_id: @ground.id).save
      expect(review).to eq(false)
    end

    it "is not valid without the ground" do
      review = Review.new(rating: 4, comments: "Bel campo", user_id: @user.id).save
      expect(review).to eq(false)
    end
    
  end
  
end
