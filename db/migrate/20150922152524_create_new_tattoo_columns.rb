class CreateNewTattooColumns < ActiveRecord::Migration
  def change
    add_column :tattoos, :studio, :string
    add_column :tattoos, :artist, :string
  end
end
