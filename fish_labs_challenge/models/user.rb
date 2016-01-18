# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  password   :string
#  created_at :datetime
#  updated_at :datetime
#  team_one   :integer          is an Array
#  team_two   :integer          is an Array
#  team_three :integer          is an Array
#

class User < ActiveRecord::Base
  validates :email, :uniqueness => true
end
