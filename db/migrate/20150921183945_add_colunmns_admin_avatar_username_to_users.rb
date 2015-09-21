class AddColunmnsAdminAvatarUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :users, :username, :string, null: false
    add_column :users, :avatar, :string, null: false,
               default: "http://www.besttats.com/pictures/tech-savy-back-tattoo.jpeg"
  end
end
