class AddNomUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :nom, :unique => true
  end

  def self.down
    remove_index :users, :nom
  end
end
