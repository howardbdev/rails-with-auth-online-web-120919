class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(access_token)

      data = access_token.info
      user = User.find_by(email: data['email'])
      
      # Uncomment the section below if you want users to be created if they don't exist
      unless user
          user = User.create(
             email: data['email'],
             password: Devise.friendly_token[0,20]
          )
      end
      user

      # User.first_or_create_by(email: data['email']) do |u|
      #   u.email = data['email']
      #   u.password = SecureRandom.hex
      # end
  end


end
