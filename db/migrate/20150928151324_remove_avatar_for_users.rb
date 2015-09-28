class RemoveAvatarForUsers < ActiveRecord::Migration
  def up
    remove_column :users, :avatar
  end
  
  def down
    add_column :users, :avatar, :string, null: false,
      default: "http://www.besttats.com/pictures/tech-savy-back-tattoo.jpeg"
  end
end
