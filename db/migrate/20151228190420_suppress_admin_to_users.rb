class SuppressAdminToUsers < ActiveRecord::Migration
  def down
    remove_column :users, :admin
  end
end
