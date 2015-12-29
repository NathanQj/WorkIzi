class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :titre
      t.string :auteur
      t.string :borrowed_by
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :books, :user_id
  end
end
