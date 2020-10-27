# coding: utf-8
require 'rails_helper'
require 'spec_helper'

RSpec.describe "Reviews", type: :request do
  
  describe "POST #create" do
    it "user creates review as player" do
      user = FactoryBot.create(:user)
      user.add_role(:player)
      ground = FactoryBot.create(:ground)
      sign_in(user) #Faccio un login sennò non posso commentare
      expect{post ground_reviews_path(user.id), params: {rating: 4, review: "Bel campo", ground_id: ground.id, user_id: user.id}}.to change(Review, :count).by(1)
      expect(Review.last.rating).to eq(4)
      expect(response).to redirect_to(ground_path(ground.id))
    end
  end

  describe "DELETE #destroy" do
    it "user destroys a review" do
      ground = FactoryBot.create(:ground)
      user = FactoryBot.create(:user)
      user.add_role(:player)
      sign_in(user) #Faccio un login sennò vengo rimandato nella pagina di login
      review = FactoryBot.build(:review)
      review.user_id = user.id
      review.ground_id = ground.id
      review.save!
      user.add_role :writer, review #Gli do' il ruolo di scrittore della recensione in modo che può cancellarla
      expect(Review.count).to eq(1)
      expect {
        delete ground_review_path(:id => review.id, :ground_id => ground.id), params: {id: review.id, ground_id: ground.id}
      }.to change(Review, :count).by(-1)
      expect(response).to redirect_to(ground_path(ground.id))
    end
  end
  
end
