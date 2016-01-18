class AddOwnedMonstersToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.integer :owned_monsters, array: true, default: []
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :owned_monsters
    end
  end
end
