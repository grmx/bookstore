class Address < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  validates :address, :zipcode, :city, :country, :phone, presence: true
  validates :zipcode, length: { is: 5 }
  validates :phone, length: { minimum: 5, maximum: 12 }

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
