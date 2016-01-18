# == Schema Information
#
# Table name: monsters
#
#  id          :integer          not null, primary key
#  name        :string
#  power       :integer
#  monstertype :string
#  created_at  :datetime
#  updated_at  :datetime
#

class Monster < ActiveRecord::Base
  validates :name, :uniqueness => true
end
