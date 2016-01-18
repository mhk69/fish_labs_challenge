class AddMonsterWeaknessToMonsters < ActiveRecord::Migration
  def self.up
    change_table :monsters do |t|
      t.string :monsterweakness
    end
  end

  def self.down
    change_table :monsters do |t|
      t.remove :monsterweakness
    end
  end
end
