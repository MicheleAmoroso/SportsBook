class User < ApplicationRecord
  rolify :before_add => :before_add_method
  after_create :assign_default_role

  def before_add_method(role)
    # do something before it gets added
  end

  def assign_default_role
    # self.add_role(:player) if self.roles.blank?
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :books
  has_many :reviews
  has_many :favorites

  has_one_attached :profile_image

  attr_writer :login
  validate :validate_username
  validates_uniqueness_of :username

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.from_omniauth(auth) 
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session) 
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
	user.email = data["email"] if user.email.blank?
      end
    end
  end
end
