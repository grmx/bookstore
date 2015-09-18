class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :orders, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :identities, dependent: :destroy

  has_one :credit_card, dependent: :destroy
  has_and_belongs_to_many :books

  validates :email, format:
    { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def add_to_wishlist(book)
    books << book
  end

  def remove_from_wishlist(book)
    books.delete book
  end

  def book_in_wishlist?(book)
    books.include?(book)
  end

  def self.find_for_oauth(auth)
    identity = Identity.find_by_provider_and_uid(auth.provider, auth.uid.to_s)
    return identity.user if identity

    email = auth.info.email
    user = User.find_by(email: email)
    if user
      user.create_identity(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password,
                          password_confirmation: password,
                          remote_avatar_url: auth.info.image)
      user.create_identity(auth)
    end
    user
  end

  def create_identity(auth)
    identities.create(provider: auth.provider, uid: auth.uid)
  end
end
