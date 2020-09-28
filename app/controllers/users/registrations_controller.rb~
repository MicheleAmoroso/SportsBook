# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    rec = Recipe.where(:user_id => current_user.id).to_a
    rec.each do |r|
      Comment.where(:recipe_id => r).destroy_all
      Like.where(:recipe_id => r).destroy_all
    end

    Recipe.where(:user_id => current_user.id).destroy_all
    Comment.where(:user_id => current_user.id).destroy_all
    Like.where(:user_id => current_user.id).destroy_all
    Favourite.where(:user_id => current_user.id).destroy_all
    Notification.where(:user_id => current_user.id).destroy_all
    Notification.where(:sender_id => current_user.id).destroy_all
    fol = Follow.where(:follower_id => current_user.id).to_a
    fol.each do |f|
      us=User.where(:id => f.following_id)
      us.each do |u|
        u.n_follower=u.n_follower-1
        u.save
      end
    end
    fol.destroy_all
    fol = Follow.where(:following_id => current_user.id).to_a
    fol.each do |f|
      us=User.where(:id => f.follower_id)
      us.each do |u|
        u.n_following=u.n_following-1
        u.save
      end
    end
    fol.destroy_all
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :first_name, :last_name, :date_of_birth, :phone_number, :gender, :bio, :img, :profile_img])  #TODO
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    user_path(current_user.id)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
