class User < ApplicationRecord
  has_one :freelancer
  after_create :create_freelancer
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :linkedin]
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid, email: auth.info.email).first_or_create do |user|
      # user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end      
  end
  
end
