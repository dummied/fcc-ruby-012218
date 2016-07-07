class AddAliasToAvengers < ActiveRecord::Migration
  def change
    add_column :avengers, :alias, :string
  end
end
