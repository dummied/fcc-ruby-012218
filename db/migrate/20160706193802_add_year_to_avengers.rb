class AddYearToAvengers < ActiveRecord::Migration
  def change
    add_column :avengers, :year, :integer
    remove_column :avengers, :probationary_introduction
    remove_column :avengers, :full_introduction
  end
end
