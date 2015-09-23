class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.string :body
      t.belongs_to :tattoo
      t.belongs_to :user
      t.timestamps
    end
  end
end
