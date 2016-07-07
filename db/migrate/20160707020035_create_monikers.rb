class CreateMonikers < ActiveRecord::Migration
  def change
    create_table :monikers do |t|
      t.references :alias, index: true, foreign_key: true
      t.references :avenger, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
