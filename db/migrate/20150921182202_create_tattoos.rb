class CreateTattoos < ActiveRecord::Migration
  def change
    create_table :tattoos do |t|
      t.string :title, null: false
      t.string :description
      t.string :url, null: false
      t.belongs_to :user, null: false
    end
  end
end
