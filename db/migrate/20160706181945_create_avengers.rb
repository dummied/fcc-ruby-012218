class CreateAvengers < ActiveRecord::Migration
  def change
    create_table :avengers do |t|
      t.string :name
      t.integer :appearances
      t.boolean :current
      t.string :gender
      t.date :probationary_introduction
      t.date :full_introduction
      t.boolean :honorary
      t.text :notes
      t.boolean :alive, default: true
      t.integer :died_times, default: 0
      t.integer :return_times, default: 0
      t.string :wiki_url

      t.timestamps null: false
    end
  end
end
