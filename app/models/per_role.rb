class PerRole < ActiveRecord::Base
  belongs_to :permission
  belongs_to :role
end
