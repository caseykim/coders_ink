class AddIndexToFavorites < ActiveRecord::Migration
  def change
    add_index :favorites, [:tattoo_id, :user_id], unique: true
  end
end
