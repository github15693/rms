class Condo < ActiveRecord::Base
  has_many :users
  has_many :bulletins
  has_many :events
  has_many :facility_categories
  has_many :facilities , :through => :facility_categories
end
