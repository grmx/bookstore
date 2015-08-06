class Book < ActiveRecord::Base
  mount_uploader :cover, CoverUploader

  belongs_to :author
  belongs_to :category

  has_many :ratings, dependent: :destroy

  validates :title, :price, :stock, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  scope :search, ->(keyword){ where('keywords LIKE ?', "%#{keyword.downcase}%") }

  before_save :set_keywords

  private

  def set_keywords
    self.keywords = [title, author.full_name, description].map(&:downcase).join(' ')
  end
end
