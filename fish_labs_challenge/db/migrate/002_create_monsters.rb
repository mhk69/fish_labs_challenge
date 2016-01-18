class CreateMonsters < ActiveRecord::Migration
  def self.up
    create_table :monsters do |t|
      t.string :name
      t.integer :power
      t.string :monstertype
      t.timestamps
    end
  end

  def self.down
    drop_table :monsters
  end
end
