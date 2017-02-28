class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :division
      t.integer :position
      t.decimal :points, precision:5, scale:2

      t.timestamps
    end
  end
end
