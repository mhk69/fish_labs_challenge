class Monster < ActiveRecord::Base
  validates :name, :uniqueness => true
end
