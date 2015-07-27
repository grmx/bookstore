class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :orders, dependent: :destroy
  has_many :identities

  validates :email,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def self.find_for_oauth(auth)
    identity = Identity.where(provider: auth.provider, uid: auth.uid.to_s).first
    return identity.user if identity

    email = auth.info[:email]
    user = User.find_by(email: email)
    if user
      user.create_identity(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password,
        password_confirmation: password)
      user.create_identity(auth)
    end
    user
  end

  def create_identity(auth)
    self.identities.create(provider: auth.provider, uid: auth.uid)
  end
end
