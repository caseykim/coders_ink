class ReviseAdminColumnsOnUsers < ActiveRecord::Migration
  def up
    remove_column :users, :admin
    add_column :users, :role, :string, null: false, default: "member"
  end
  
  def down
    add_column :users, :admin, :boolean, default: false, null: false
    remove_column :users, :role
  end
end
