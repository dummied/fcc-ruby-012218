class RemoveAliasFromAvengers < ActiveRecord::Migration
  def change
    remove_column :avengers, :alias
  end
end
