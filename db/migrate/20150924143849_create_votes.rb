class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :score, null: false
      t.belongs_to :review
      t.belongs_to :user
    end
    add_index(:votes, [:review_id, :user_id], unique: true)
  end
end
