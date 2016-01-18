class AddTeamsToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.integer :team_one, array: true, default: []
    t.integer :team_two, array:true, default: []
    t.integer :team_three, array:true, default: []
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :team_one, array: true
    t.remove :team_two, array: true
    t.remove :team_three, array: true
    end
  end
end
