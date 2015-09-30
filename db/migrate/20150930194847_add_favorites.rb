class AddFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.belongs_to :tattoo
      t.belongs_to :user
      t.timestamps
    end
  end
end
